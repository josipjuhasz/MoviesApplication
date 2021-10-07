///
//  ViewController.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    let homeViewModel: HomeViewModel
    let disposeBag = DisposeBag()
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeViewModel.loadDataSubject.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        reloadTableView()
    }
}

private extension HomeViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(progressView)
        view.addSubview(tableView)
        view.bringSubviewToFront(progressView)
        setupConstraints()
        setupTableView()
        setupHomeViewModel()
    }
    
    func setupHomeViewModel(){
        disposeBag.insert(homeViewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: homeViewModel.loaderSubject).disposed(by: disposeBag)
        initializeMovieDataObservable(subject: homeViewModel.movieDataRelay).disposed(by: disposeBag)
        initializeGenreDataObservable(subject: homeViewModel.genreDataRelay).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieTableViewCell")
    }
    
    func setupConstraints() {
        progressView.snp.makeConstraints{ (make) -> Void in
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.movieDataRelay.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let movie = homeViewModel.movieDataRelay.value[indexPath.row]
        let checkValue = UserDefaults.standard.bool(forKey: "mvvmCheck\(movie.id)")
        let favoriteValue = UserDefaults.standard.bool(forKey: "mvvmFavorite\(movie.id)")
    
        cropCell.configureCell(movieName: movie.title, groupNames: homeViewModel.setupGenres(groups: movie.genreIds), imageUrl: movie.posterPath, date: movie.releaseDate, check: checkValue, favorite: favoriteValue)
        return cropCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = homeViewModel.movieDataRelay.value[indexPath.row]

        self.changeVC(movie: movie, groups: self.homeViewModel.setupGenres(groups: movie.genreIds), movieIndex: indexPath.row)
            
    }
}

private extension HomeViewController {
    
    func changeVC(movie: Details, groups: String, movieIndex: Int){
       
        let detailVc = DetailViewController(viewModel: DetailViewModelImpl(movie: movie, group: groups, index: movieIndex))
        self.navigationController?.pushViewController(detailVc, animated: true)
        
    }
}

extension HomeViewController {
    func initializeLoaderObservable(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (status) in
                if status {
                    showLoader()
                } else {
                    hideLoader()
                }
            })
    }
    
    func initializeMovieDataObservable(subject: BehaviorRelay<[Details]>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (items) in
                if !items.isEmpty {
                    tableView.reloadData()
                }
        })
    }
    
    func initializeGenreDataObservable(subject: BehaviorRelay<[Genres]>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (items) in
                if !items.isEmpty {
                    tableView.reloadData()
                }
        })
    }
}

extension HomeViewController: ReloadTableViewDelegate {
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension HomeViewController: LoaderDelegate {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}



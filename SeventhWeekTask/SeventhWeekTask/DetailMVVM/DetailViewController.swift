//
//  DetailViewController.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    let detailViewModel: DetailViewModelImpl
    let disposeBag = DisposeBag()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Icon"), for: .normal)
        return button
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let groupsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Bold", size: 20)
        label.textColor = .white
        label.text = "Director: "
        return label
    }()
    
    let directorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 20)
        label.textColor = .white
        return label
    }()
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-Regular", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let buttonChecked: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 0.475, green: 0.729, blue: 0.757, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        button.tintColor = UIColor(red: 0.475, green: 0.729, blue: 0.757, alpha: 1)
        return button
    }()
    
    let buttonFavorite: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 0.475, green: 0.729, blue: 0.757, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        button.tintColor = UIColor(red: 0.475, green: 0.729, blue: 0.757, alpha: 1)
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        detailViewModel.loadDataSubject.onNext(())
    }
    
    override func viewDidLayoutSubviews() {
        movieImageView.addBlackGradientLayerInBackground(colors: [UIColor.init(white: 0, alpha: 0.9), .clear])
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    
    init(viewModel: DetailViewModelImpl) {
        self.detailViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
}

extension DetailViewController {
    func setupUI(){
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(movieTitleLabel)
        view.addSubview(scrollView)
        view.addSubview(movieImageView)
        view.addSubview(backButton)
        view.addSubview(buttonChecked)
        view.addSubview(buttonFavorite)
        scrollView.addSubview(contentView)
        contentView.addSubview(directorNameLabel)
        contentView.addSubview(groupsLabel)
        contentView.addSubview(directorLabel)
        contentView.addSubview(descriptionLabel)
        setupConstraints()
        setupVM()
        setupValues()
        setupButtons()
    }
}

extension DetailViewController {
    func setupConstraints(){
        
        movieImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        movieTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(movieImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints{(make) in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{ (make) in
            make.trailing.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        groupsLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        directorLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(groupsLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        
        directorNameLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(groupsLabel.snp.bottom).offset(10)
            make.leading.equalTo(directorLabel.snp.trailing).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints{(make) in
            make.top.equalTo(directorLabel.snp.bottom).offset(10)
            make.bottom.equalTo(scrollView)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(view).offset(-15)
        }
        
        backButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        buttonFavorite.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        buttonChecked.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(buttonFavorite).offset(-50)
        }
    }
    
    func setupValues(){
        
        movieTitleLabel.text = detailViewModel.movie?.title
        guard let safeUrl = detailViewModel.movie?.backdropPath else {return}
        movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(safeUrl)"))
        descriptionLabel.text = detailViewModel.movie?.overview
        groupsLabel.text = detailViewModel.groupsValue
    }
    
    func setupButtons(){
        
        buttonChecked.isSelected = UserDefaults.standard.bool(forKey: "mvvmCheck\(detailViewModel.movie?.id ?? 0)")
        buttonFavorite.isSelected = UserDefaults.standard.bool(forKey: "mvvmFavorite\(detailViewModel.movie?.id ?? 0)")
        setupButton(sender: buttonChecked, button: .check)
        setupButton(sender: buttonFavorite, button: .favorite)
    }
    
    func setupVM(){
        disposeBag.insert(detailViewModel.initializeViewModelObservables())
        initializeDirectorDataObservable(subject: detailViewModel.directorDataRelay).disposed(by: disposeBag)
        
        buttonChecked.rx.tap
            .bind{
                self.detailViewModel.watchedButtonPressed(sender: self.buttonChecked)
                self.setupButton(sender: self.buttonChecked, button: .check)
            }
            .disposed(by: disposeBag)
        
        buttonFavorite.rx.tap
            .bind{
                self.detailViewModel.favoriteButtonPressed(sender: self.buttonFavorite)
                self.setupButton(sender: self.buttonFavorite, button: .favorite)
            }
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind{
                self.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {
    func setupButton(sender: UIButton, button: buttonType){
        switch button {
        case .favorite:
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            sender.setImage(UIImage(systemName: "star.fill"), for: .selected)
        case .check:
            sender.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
            sender.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .selected)
        }
    }
}

extension DetailViewController{
    func initializeDirectorDataObservable(subject: BehaviorRelay<String>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (director) in
                directorNameLabel.text = director
            })
    }
}

enum buttonType {
    case check
    case favorite
}

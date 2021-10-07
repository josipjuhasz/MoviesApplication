//
//  DetailViewModelImpl.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 15.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailViewModelImpl: DetailViewModel {
        
    var directorValue: String = ""
    var movie: Details?
    var groupsValue: String?
    var movieIndex: Int?
    
    var directorDataRelay = BehaviorRelay<String>.init(value: "")
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    
    let repository = RepositoryImpl(movieServiceAPI: MovieServiceAPI())
    
    init(movie: Details, group: String, index: Int) {
        self.movie = movie
        self.groupsValue = group
        self.movieIndex = index
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadDirectorSubject(subject: loadDataSubject))
        return disposables
    }
    
    func watchedButtonPressed(sender: UIButton){
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: "mvvmCheck\(movie?.id ?? 0)")
    }
    
    func favoriteButtonPressed(sender: UIButton){
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: "mvvmFavorite\(movie?.id ?? 0)")
    }
}

extension DetailViewModelImpl {
    func initializeLoadDirectorSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<CreditsResponse> in
                return self.repository.getDirector(id: movie?.id ?? 0)
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (creditResponse) in
                self.directorValue = ""
                creditResponse.crew.forEach({ value in
                    if value.knownForDepartment == .directing {
                        self.directorValue = value.name
                    }
                })
                self.directorDataRelay.accept(self.directorValue)
            })
    }
}

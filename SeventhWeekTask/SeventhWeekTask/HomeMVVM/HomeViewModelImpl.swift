//
//  HomeViewModelImpl.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 13.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeVideoModelImpl: HomeViewModel {
    
    var movieDataRelay = BehaviorRelay<[Details]>.init(value: [])
    var genreDataRelay = BehaviorRelay<[Genres]>.init(value: [])
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 2)
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadMoviesSubject(subject: loadDataSubject))
        disposables.append(initializeLoadGenresSubject(subject: loadDataSubject))
        return disposables
    }
    
    func setupGenres(groups: [Int]) -> String{
        
        var genres: String = ""
        
        for genre in groups {
            
            genreDataRelay.value.forEach({
                if genre == $0.id {
                    genres.append($0.name)
                    genres.append(", ")
                }
            })
        }
        return String(genres.dropLast(2))
    }
}

private extension HomeVideoModelImpl {
    func initializeLoadMoviesSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<NowPlayingResponse> in
                self.loaderSubject.onNext(true)
                return self.repository.getMovies()
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (movieResponse) in
                guard let movies = movieResponse.results else {
                    return
                }
                self.movieDataRelay.accept(movies)
                self.loaderSubject.onNext(false)
            })
    }
    
    func initializeLoadGenresSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<GenresResponse> in
                self.loaderSubject.onNext(true)
                return self.repository.getGenres()
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (genreResponse) in
                guard let genres = genreResponse.genres else {
                    return
                }
                self.genreDataRelay.accept(genres)
                self.loaderSubject.onNext(false)
            })
    }
}

//
//  HomeViewModel.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 13.07.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel: AnyObject {
    
    var movieDataRelay: BehaviorRelay<[Details]> {get}
    var genreDataRelay: BehaviorRelay<[Genres]> {get}
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
    func setupGenres(groups: [Int]) -> String
}

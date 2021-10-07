//
//  DetailViewModel.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 15.07.2021..
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol DetailViewModel: AnyObject {
    
    var movie: Details? { get }
    var groupsValue: String? { get }
    var movieIndex: Int? { get }
    var directorDataRelay: BehaviorRelay<String> {get}
    var loadDataSubject: ReplaySubject<()> {get}

    
    func watchedButtonPressed(sender: UIButton)
    func favoriteButtonPressed(sender: UIButton)
}

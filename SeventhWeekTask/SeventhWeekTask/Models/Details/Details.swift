//
//  Details.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation

public struct Details: Codable {
    
    public let backdropPath: String
    public let genreIds: [Int]
    public let id: Int
    public let overview: String?
    public let posterPath: String
    public let productionCompanies: [ProductionCompanies]?
    public let productionCountries: [ProductionCountries]?
    public let releaseDate: String
    public let spokenLanguages: [SpokenLanguages]?
    public let title: String
    public var director: String?
    var isFavorite:Bool?
    var isChecked:Bool?
}

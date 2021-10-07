//
//  NowPlayingResults.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation

public struct NowPlayingResults: Codable{
    
    public let posterPath: String
    public let adult: Bool
    public let overview: String
    public let releaseDate: String
    public let genreIds: [Int]
    public let id: Int
    public let originalTitle: String
    public let originalLanguage: String
    public let title: String
    public let backdropPath: String
    public let popularity: Double
    public let voteCount: Int
    public let video: Bool
    public let voteAverage: Double
    var isFavorite:Bool?
    var isChecked:Bool?
}

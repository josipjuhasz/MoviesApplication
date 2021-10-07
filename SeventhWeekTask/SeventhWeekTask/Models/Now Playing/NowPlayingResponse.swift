//
//  NowPlayingResponse.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation

public struct NowPlayingResponse: Codable {
    
    public let page: Int?
    public let results: [Details]?
    public let dates: NowPlayingDate?
    public let totalPages: Int?
    public let totalResults: Int?
}

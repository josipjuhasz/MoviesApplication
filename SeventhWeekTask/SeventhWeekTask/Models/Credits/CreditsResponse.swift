//
//  CreditsResponse.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation

public struct CreditsResponse: Codable {
    
    public let id: Int
    public let cast: [Credits]
    public let crew: [Credits]
}

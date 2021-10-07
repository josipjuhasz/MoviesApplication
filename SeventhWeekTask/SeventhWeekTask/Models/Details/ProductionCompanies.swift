//
//  ProductionCompanies.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation

public struct ProductionCompanies: Codable {
    
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String?
}

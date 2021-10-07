//
//  Credits.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation

public struct Credits: Codable {
    
    public let adult: Bool?
    public let gender: Int
    public let id: Int
    public let name: String
    public let originalName: String
    public let popularity: Double
    public let profilePath: String?
    public let castId: Int?
    public let character: String?
    public let creditId: String?
    public let order: Int?
    let knownForDepartment: Department?
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}


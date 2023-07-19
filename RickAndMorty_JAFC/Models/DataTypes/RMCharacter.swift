//
//  RMCharacter.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


// MARK: - Result
struct RMCharacterResult: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus?
    let species, type: String?
    let gender: RMCharacterGender?
    let origin, location: RMCharacterLocation?
    let image: String
    let episode: [String]?
    let url: String
    let created: String?
}


enum RMCharacterGender: String, Codable {
    case female     = "Female"
    case male       = "Male"
    case genderless = "Genderless"
    case unknown    = "unknown"
}


// MARK: - Location
struct RMCharacterLocation: Codable {
    let name: String?
    let url: String?
}


enum RMCharacterStatus: String, Codable {
    case alive     = "Alive"
    case dead      = "Dead"
    case `unknown` = "unknown"
    
    var statusText: String {
        switch self {
        case .alive, .dead:
            return rawValue
            
        case .unknown:
            return "Unknown"
        }
    }
}

//
//  RMCharacter.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


// MARK: - RMCharacter
struct RMCharacter: Codable {
    let info: RMCharacterInfo?
    let results: [RMCharacterResult]?
}


// MARK: - Info
struct RMCharacterInfo: Codable {
    let count, pages: Int?
    let next, prev: String?
}


// MARK: - Result
struct RMCharacterResult: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus?
    let species, type: String?
    let gender: RMCharacterGender?
    let origin, location: RMCharacterLocation?
    let image: String?
    let episode: [String]?
    let url: String?
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
}

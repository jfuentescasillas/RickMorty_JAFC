//
//  RMLocation.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


// MARK: - RMLocation
struct RMLocation: Codable {
    let info: RMLocationInfo?
    let results: [RMLocationResult]?
}


// MARK: - Info
struct RMLocationInfo: Codable {
    let count, pages: Int?
    let next, prev: String?
}


// MARK: - Result
struct RMLocationResult: Codable {
    let id: Int
    let name: String
    let type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}

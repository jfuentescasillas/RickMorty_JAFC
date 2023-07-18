//
//  RMEpisode.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


// MARK: - RMEpisode
struct RMEpisode: Codable {
    let info: RMEpisodeInfo?
    let results: [RMEpisodeResult]?
}


// MARK: - Info
struct RMEpisodeInfo: Codable {
    let count, pages: Int?
    let next, prev: String?
}


// MARK: - Result
struct RMEpisodeResult: Codable {
    let id: Int
    let name: String
    let airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

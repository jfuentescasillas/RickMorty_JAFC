//
//  RMEpisode.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


// MARK: - RMEpisode
struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    /* let id: Int
    let name: String
    let airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    } */
}

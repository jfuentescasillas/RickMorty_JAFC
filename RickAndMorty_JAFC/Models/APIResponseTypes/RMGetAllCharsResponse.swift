//
//  RMGetAllCharsResponse.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import Foundation


/// This model is used to get a list of characters


struct RMGetAllCharsResponse: Codable {
    let info: RMGetAllCharsInfo
    let results: [RMCharacterResult]
    
    
    // MARK: - RMGetAllCharsInfo
    struct RMGetAllCharsInfo: Codable {
        let count, pages: Int
        let next, prev: String?
    }
}

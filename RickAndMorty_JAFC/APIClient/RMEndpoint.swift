//
//  RMEndpoint.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


/// Unique API enpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character's info
    case character
    
    /// Endpoint to get location's info
    case location
    
    /// Endpoint to get episode's info
    case episode
}

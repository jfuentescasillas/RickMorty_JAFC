//
//  RMEndpoint.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation

/*
 Hashable needed to cache images in RMAPICacheManager,
 in its cacheDict variable.
 
 Iterable is used to be able to loop over all 3 endpoints
 (character, location and episode) in the configCache()
 method of the RMAPICacheManager class.
 */
/// Unique API enpoint
enum RMEndpoint: String, Hashable, CaseIterable {
    /// Endpoint to get character's info
    case character
    
    /// Endpoint to get location's info
    case location
    
    /// Endpoint to get episode's info
    case episode
}

//
//  RMService.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


/// Primary Object. API Service to get Rick & Morty data
final class RMService {
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Private constructor
    private init () {}
    
    
    /// Send Rick & Morty API Call
    /// -Parameters:
    ///  - `request`: Request Instance
    ///  - `type`: Type of object that we expect to get back
    ///  - `completion`: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}

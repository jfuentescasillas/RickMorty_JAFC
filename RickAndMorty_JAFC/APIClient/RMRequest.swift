//
//  RMRequest.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//

/*
 Base URL
 Endpoint
 Path Components
 Query Parameters
 
 List of characters using pagination: https://rickandmortyapi.com/api/character/?page=2
 Character's details using its id:    https://rickandmortyapi.com/api/character/2
 List of locations of the Character:  https://rickandmortyapi.com/api/location
 List of episodes of the Character:   https://rickandmortyapi.com/api/episode
 */


import Foundation


/// Object representing a single API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
    
    // MARK: - Private Properties
    /// Desired Endpoint
    private let endpoint: RMEndpoint
    
    /// API Path Components (if any)
    private let pathComponents: [String]
    
    /// API Query Arguments (if any)
    private let queryParams: [URLQueryItem]
    
    
    /// Constructed URL for the API request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParams.isEmpty {
            string += "?"
            
            let argumentString = queryParams.compactMap {
                guard let value = $0.value else { return nil }
                
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired httpMethod
    public let httpMethod = "GET"
    
    
    // MARK: - Public Init
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target Endpoint
    ///   - pathComponents: Collection of Path Components
    ///   - queryParams: Collection of Query Parameters
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParams: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }
}


// MARK: - Extension
extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}

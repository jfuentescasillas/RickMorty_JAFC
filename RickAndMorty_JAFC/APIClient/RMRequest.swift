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
        static let baseUrl = "https://rickandmortyapi.com/api"
    }

    /// Desired endpoint
    let endpoint: RMEndpoint

    /// Path components for API (if any)
    private let pathComponents: [String]

    /// Query arguments for API (if any)
    private let queryParams: [URLQueryItem]

    /// URL built for the api request using string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }

        if !queryParams.isEmpty {
            string += "?"
            
            let argumentString = queryParams.compactMap({
                guard let value = $0.value else { return nil }
               
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            string += argumentString
        }

        return string
    }

    /// API url Computed & constructed
    public var url: URL? {
        return URL(string: urlString)
    }

    /// Desired http method
    public let httpMethod = "GET"

    // MARK: - Inits
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParams = queryParameters
    }

    /// Attempt the creation of the request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            
            if !components.isEmpty {
                let endpointString = components[0]  // Endpoint
                var pathComponents: [String] = []
               
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                   
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                
                // This is like value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    
                    let parts = $0.components(separatedBy: "=")

                    return URLQueryItem(name: parts[0], value: parts[1])
                })

                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    
                    return
                }
            }
        }

        return nil
    }
}


// MARK: - Request convenience
extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}

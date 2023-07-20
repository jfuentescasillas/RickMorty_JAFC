//
//  RMService.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import Foundation


/// Primary Object. API Service to get Rick & Morty data
final class RMService {
    // MARK: - Properties
    // MARK: Public Properties
    /// Shared singleton instance
    static let shared = RMService()
    
    // MARK: Private Properties
    private let cacheManager = RMAPICacheManager()
    
    // MARK: - Init
    /// Private constructor
    private init () {}
    
    
    // MARK: Public Methodes
    /// Send Rick & Morty API Call
    /// -Parameters:
    ///  - `request`: Request Instance
    ///  - `type`: Type of object that we expect to get back
    ///  - `completion`: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint,
                                                        url: request.url) {
            print("++++++++Seeing information from cache. Cache API response used++++++++")
            
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data, error == nil, let self else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
            
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                
                // Save in cache what has been requested
                print("-------Saving data to the Cache from the API response-------")
                self.cacheManager.setCache(for: request.endpoint,
                                           url: request.url,
                                           data: data)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    // MARK: - Private methods
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}

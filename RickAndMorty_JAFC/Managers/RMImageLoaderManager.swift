//
//  RMImageLoaderManager.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import Foundation


final class RMImageLoaderManager {
    // MARK: - Properties
    // MARK: Public Properties
    static let shared = RMImageLoaderManager()
    
    // MARK: Private Properties
    private var imgCache = NSCache<NSString, NSData>()
    
    // MARK: - Private Init
    private init () {}
    
    
    // MARK: - Public Methods
    /// Get image from URL and Cache it
    /// - Parameters:
    ///   - url: Image's source URL
    ///   - completion: callback with data or error
    public func downloadImg(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString // Use `String` directly
        
        if let data = imgCache.object(forKey: key as NSString) { // Cast `String` to `NSString` when accessing the cache
            completion(.success(data as Data))
           
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data, let self, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                
                return
            }
            
            let value = data as NSData
            self.imgCache.setObject(value, forKey: key as NSString) // Cast `String` to `NSString` here as well
            completion(.success(data))
        }
        
        task.resume()
    }
}

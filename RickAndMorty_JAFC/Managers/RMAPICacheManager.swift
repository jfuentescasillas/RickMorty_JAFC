//
//  RMAPICacheManager.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 20/07/23.
//


import Foundation


/// Manages in memory API Cached
final class RMAPICacheManager {
    // MARK: - Properties
    // MARK: Private Properties
    private var cacheDict: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    private var cache = NSCache<NSString, NSData>()
    
    
    // MARK: - Inits
    init () {
        configCache()
    }
    
    
    // MARK: - Private Methods
    private func configCache() {
        RMEndpoint.allCases.forEach { endpoint in
            cacheDict[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
    
    // MARK: - Public Methods
    // Check if something is available in the cache
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDict[endpoint],
              let url
        else {
            return nil
        }
        
        let key = url.absoluteString as NSString
               
        return targetCache.object(forKey: key) as? Data
    }
    
    
    // Add something to the cache
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDict[endpoint],
              let url
        else {
            return
        }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
}

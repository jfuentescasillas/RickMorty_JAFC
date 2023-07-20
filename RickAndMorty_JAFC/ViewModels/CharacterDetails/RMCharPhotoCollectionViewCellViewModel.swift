//
//  RMCharPhotoCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import Foundation


final class RMCharPhotoCollectionViewCellViewModel {
    // MARK: - Properties
    // MARK: Private Properties
    private let imgURL: URL?
    
    
    // MARK: - Inits
    init (imgURL: URL?) {
        self.imgURL = imgURL
    }
    
    
    // MARK: - Public Methods
    public func fetchImg(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imgURL else {
            completion(.failure(URLError(.badURL)))
            
            return
        }
        
        RMImageLoaderManager.shared.downloadImg(url: imgURL, completion: completion)
    }
}

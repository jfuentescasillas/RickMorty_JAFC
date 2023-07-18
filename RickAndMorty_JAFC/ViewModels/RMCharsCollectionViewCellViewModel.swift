//
//  RMCharsCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import Foundation


final class RMCharsCollectionViewCellViewModel {
    // MARK: - Properties
    public let charName: String
    private let charStatus: RMCharacterStatus
    private let charImgURL: URL?
    
    
    // MARK: - Init
    init (charName: String,
          charStatus: RMCharacterStatus,
          charImgURL: URL?) {
        self.charName = charName
        self.charStatus = charStatus
        self.charImgURL = charImgURL
    }
    
    
    // MARK: - Other Properties
    public var charStatusTxt: String {
        return "Status: \(charStatus.statusText)"
    }
    
    
    // MARK: - Public methods
    public func fetchImg(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = charImgURL else {
            completion(.failure(URLError(.badURL)))
            
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

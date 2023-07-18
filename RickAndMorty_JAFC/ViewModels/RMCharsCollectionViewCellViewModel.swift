//
//  RMCharsCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import Foundation


final class RMCharsCollectionViewCellViewModel: Hashable, Equatable {
    // MARK: - Properties
    // MARK: Public Properties
    public let charName: String
    public var charStatusTxt: String {
        return "Status: \(charStatus.statusText)"
    }
    
    // MARK: Private Properties
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
    
    
    // MARK: - Hashable
    static func == (lhs: RMCharsCollectionViewCellViewModel, rhs: RMCharsCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(charImgURL)
        hasher.combine(charName)
        hasher.combine(charStatus)
    }
}

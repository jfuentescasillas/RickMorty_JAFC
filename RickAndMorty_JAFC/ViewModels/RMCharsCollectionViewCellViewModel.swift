//
//  RMCharsCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import Foundation

/*
 * Hashable and Equatable are used to get rid of the duplicated elements after
 * calling new characters in the pagination. To filter something that already
 * exists. A character ViewModel is created and a unique hash is wanted; this
 * is where Hashable is used (and its protocol stubs are implemented).
 *
 * This Hashable is related to the RMCharsListViewViewModel. See the commented
 * section inside charsList variable
 */
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
        
        RMImageLoaderManager.shared.downloadImg(url: url, completion: completion)
    }
    
    
    // MARK: - Hashable
    static func == (lhs: RMCharsCollectionViewCellViewModel, rhs: RMCharsCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    // Whe tell the viewModel whenever it's created, what the unique hash value for it is.
    func hash(into hasher: inout Hasher) {
        hasher.combine(charImgURL)
        hasher.combine(charName)
        hasher.combine(charStatus)
    }
}

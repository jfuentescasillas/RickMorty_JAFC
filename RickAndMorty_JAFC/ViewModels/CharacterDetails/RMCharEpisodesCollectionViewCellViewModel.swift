//
//  RMCharEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import Foundation


final class RMCharEpisodesCollectionViewCellViewModel {
    // MARK: - Properties
    // MARK: Private Properties
    private let episodeDataURL: URL?
    
    
    // MARK: - Inits
    init (episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
}

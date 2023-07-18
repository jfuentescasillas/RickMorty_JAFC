//
//  RMCharDetailsViewViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import Foundation


final class RMCharDetailsViewViewModel {
    // MARK: - Properties
    // MARK: Private Properties
    private let character: RMCharacterResult
    
    // MARK: - Inits
    init(character: RMCharacterResult) {
        self.character = character
    }
    
    // MARK: - Public Properties
    public var title: String {
        character.name.uppercased()
    }
}

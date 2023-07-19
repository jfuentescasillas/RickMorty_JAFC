//
//  RMCharDetailsViewViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import UIKit


final class RMCharDetailsViewViewModel {
    // MARK: - Enums
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    
    // MARK: - Properties
    // MARK: Private Properties
    private let character: RMCharacterResult
    private var requestURL: URL? {
        return URL(string: character.url)
    }
    
    // MARK: Public Properties
    public let sections = SectionType.allCases
    public var title: String {
        character.name.uppercased()
    }
    
    // MARK: - Inits
    init(character: RMCharacterResult) {
        self.character = character
    }
    
    
    // MARK: - Public Layout Methods
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0,
                                                     bottom: 10, trailing: 0)
       
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.75)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let padding: CGFloat = 2
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding,
                                                      bottom: padding, trailing: padding)
       
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(75)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let padding: CGFloat = 10
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 5,
                                                     bottom: padding, trailing: 8)
       
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

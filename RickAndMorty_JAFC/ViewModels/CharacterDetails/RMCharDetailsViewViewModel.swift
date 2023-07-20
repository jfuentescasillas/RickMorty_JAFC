//
//  RMCharDetailsViewViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import UIKit


final class RMCharDetailsViewViewModel {
    // MARK: - Enums
    enum SectionType {
        case photo(viewModel: RMCharPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharEpisodesCollectionViewCellViewModel])
    }
    
    
    // MARK: - Properties
    // MARK: Private Properties
    private let character: RMCharacterResult
    private var requestURL: URL? {
        return URL(string: character.url)
    }
    
    // MARK: Public Properties
    public var sections = [SectionType]()
    public var episodes: [String] {
        character.episode
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    // MARK: - Inits
    init(character: RMCharacterResult) {
        self.character = character
        
        configSections()
    }
    
    
    // MARK: - Private Methods
    private func configSections() {
        sections = [
            .photo(viewModel: .init(imgURL: URL(string: character.image))),
            .information(viewModels: [
                .init(charType: .status, value: character.status.statusText),
                .init(charType: .type, value: character.type),
                .init(charType: .gender, value: character.gender.statusText),
                .init(charType: .species, value: character.species),
                .init(charType: .origin, value: character.origin.name),
                .init(charType: .location, value: character.location.name),
                .init(charType: .created, value: character.created),
                .init(charType: .episodeCount, value: "\(character.episode.count)")
            ]),
            .episodes(viewModels: character.episode.compactMap {
                return RMCharEpisodesCollectionViewCellViewModel(episodeDataURL: URL(string: $0))
            })
        ]
    }
    
    
    // MARK: - Public Layout Methods
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0,
                                                     bottom: 10, trailing: 0)
       
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.7)
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
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding,
                                                      bottom: padding, trailing: padding)
       
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(150)
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

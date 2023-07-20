//
//  RMCharEpisodesCollectionViewCell.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import UIKit


final class RMCharEpisodesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    // MARK: Public Properties
    static let cellIdentifier: String = "RMCharEpisodesCollectionViewCell"

    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    // MARK: - Private Methods
    private func configConstraints() {
        
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharEpisodesCollectionViewCellViewModel) {
        
    }
}

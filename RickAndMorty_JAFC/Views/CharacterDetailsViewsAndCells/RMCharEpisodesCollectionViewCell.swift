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

    // MARK: Private Properties
    private let seasonLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        
        return label
    }()
    
    private let airDateLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configContentView()
        configConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        
        seasonLbl.text = nil
        nameLbl.text = nil
        airDateLbl.text = nil
    }
    
    
    // MARK: - Private Methods
    private func configContentView() {
        contentView.backgroundColor    = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth  = 2
        contentView.layer.borderColor  = UIColor.systemCyan.cgColor
        
        contentView.addSubviews(seasonLbl, nameLbl, airDateLbl)
    }
    
    
    private func configConstraints() {
        let padding: CGFloat = 10
        let multiplier: CGFloat = 0.3
        
        NSLayoutConstraint.activate([
            seasonLbl.topAnchor.constraint (equalTo: contentView.topAnchor),
            seasonLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            seasonLbl.rightAnchor.constraint (equalTo: contentView.rightAnchor, constant: -padding),
            seasonLbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: multiplier),
            
            nameLbl.topAnchor.constraint (equalTo: seasonLbl.bottomAnchor),
            nameLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            nameLbl.rightAnchor.constraint (equalTo: contentView.rightAnchor, constant: -padding),
            nameLbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: multiplier),
            
            airDateLbl.topAnchor.constraint (equalTo: nameLbl.bottomAnchor),
            airDateLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            airDateLbl.rightAnchor.constraint (equalTo: contentView.rightAnchor, constant: -padding),
            airDateLbl.heightAnchor.constraint (equalTo: contentView.heightAnchor, multiplier: multiplier)
        ])
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharEpisodesCollectionViewCellViewModel) {
        // To prevent fetching the image from the URL when scrolling the episodes
        viewModel.registerForData { [weak self] data in
            guard let self else { return }
            
            self.nameLbl.text = data.name
            self.seasonLbl.text = "Episode " + data.episode
            self.airDateLbl.text = "Aired on " + data.air_date
            
        }
        
        viewModel.fetchEpisode()
    }
}

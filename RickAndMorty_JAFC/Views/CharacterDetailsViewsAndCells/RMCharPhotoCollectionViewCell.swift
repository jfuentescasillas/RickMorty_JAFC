//
//  RMCharPhotoCollectionViewCell.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import UIKit


final class RMCharPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    // MARK: Public Properties
    static let cellIdentifier: String = "RMCharPhotoCollectionViewCell"
    
    // MARK: Private Properties
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode   = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        configConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    
    // MARK: - Private Methods
    private func configConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharPhotoCollectionViewCellViewModel) {
        viewModel.fetchImg { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                
            case .failure(let failure):
                print("Failed loading data from cache: \(failure)")
                
                break
            }
        }
    }
}

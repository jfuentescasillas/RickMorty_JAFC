//
//  RMCharInfoCollectionViewCell.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import UIKit


final class RMCharInfoCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    // MARK: Public Properties
    static let cellIdentifier: String = "RMCharInfoCollectionViewCell"

    
    // MARK: Private Properties
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private let valueLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()
    
    private let iconImgView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        
        return icon
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLbl, iconImgView)
        
        titleContainerView.addSubview(titleLbl)
        configConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLbl.text = nil
        titleLbl.textColor = .label
        
        valueLbl.text = nil
        
        iconImgView.image = nil
        iconImgView.tintColor = .label
        
    }
    
    
    // MARK: - Private Methods
    private func configConstraints() {
        let squarePadding: CGFloat = 30  // To give a square shape to the iconImgView
        let lateralPadding: CGFloat = 10  // Used in left and right anchors
        let topPadding: CGFloat = 35
        
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            titleLbl.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLbl.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLbl.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImgView.widthAnchor.constraint(equalToConstant: squarePadding),
            iconImgView.heightAnchor.constraint(equalToConstant: squarePadding),
            iconImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
            iconImgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            valueLbl.leftAnchor.constraint(equalTo: iconImgView.rightAnchor, constant: lateralPadding),
            valueLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -lateralPadding),
            valueLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLbl.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
        ])
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharInfoCollectionViewCellViewModel) {
        titleLbl.text = viewModel.title
        titleLbl.textColor = viewModel.tintColor
        valueLbl.text = viewModel.displayValue
        iconImgView.image = viewModel.iconImage
        iconImgView.tintColor = viewModel.tintColor
        
    }
}

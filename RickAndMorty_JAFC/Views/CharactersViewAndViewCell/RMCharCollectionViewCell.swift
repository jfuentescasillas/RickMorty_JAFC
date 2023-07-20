//
//  RMCharCollectionViewCell.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import UIKit


/// Single Character's cell
class RMCharCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    // MARK: Public Properties
    public static let cellIdentifier = "RMCharCollectionViewCell"
    
    // MARK: Private Properties
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode   = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private let nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18,
                                 weight: .medium)
        
        return label
    }()

    private let statusLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16,
                                 weight: .regular)
        
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        configContentView()
        configConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLbl.text    = nil
        statusLbl.text  = nil
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configContentView()
    }
    
    
    // MARK: - Private Methods
    private func configContentView() {
        contentView.addSubviews(imageView, nameLbl, statusLbl)
        
        contentView.backgroundColor     = .secondarySystemBackground
        contentView.layer.cornerRadius  = 8
        contentView.layer.shadowColor   = UIColor.label.cgColor
        contentView.layer.shadowOffset  = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    
    private func configConstraints() {
        let heightPadding: CGFloat   = 30
        let lateralPadding: CGFloat  = 7
        let verticalPadding: CGFloat = 3
        
        NSLayoutConstraint.activate([
            /* Desired Layout:
             | IMAGE |
             | NAME |
             | STATUS |
             */
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLbl.topAnchor, constant: -verticalPadding),
            
            nameLbl.heightAnchor.constraint(equalToConstant: heightPadding),
            nameLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: lateralPadding),
            nameLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -lateralPadding),
            nameLbl.bottomAnchor.constraint(equalTo: statusLbl.topAnchor),
            
            statusLbl.heightAnchor.constraint(equalToConstant: heightPadding),
            statusLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: lateralPadding),
            statusLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -lateralPadding),
            statusLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding)
        ])        
    }
    
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharsCollectionViewCellViewModel) {
        nameLbl.text = viewModel.charName
        statusLbl.text = viewModel.charStatusTxt
        viewModel.fetchImg { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let img = UIImage(data: data)
                    self.imageView.image = img
                }
                
            case .failure(let error):
                print(String(describing: error))
                
                break
            }
        }
    }
}

//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import UIKit


final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    // MARK: - Properties
    // MARK: Public Properties
    static public let identifier: String = "RMFooterLoadingCollectionReusableView"
    
    // MARK: Private Properties
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(spinner)
        
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    private func configConstraints() {
        let squarePadding: CGFloat = 100

        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: squarePadding),
            spinner.heightAnchor.constraint(equalToConstant: squarePadding),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    // MARK: - Public Methods
    public func startAnimating() {
        spinner.startAnimating()
    }
}

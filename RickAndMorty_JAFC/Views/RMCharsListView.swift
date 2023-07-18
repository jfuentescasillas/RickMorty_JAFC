//
//  RMCharsListView.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import UIKit


/// View that shows the list of characters and the activity indicator (spinning loader)
final class RMCharsListView: UIView {
    // MARK: - Private Properties
    private let viewModel = RMCharsListViewViewModel()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RMCharCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        
        addAllConstraints()
        
        spinner.startAnimating()
        
        viewModel.delegate = self
        viewModel.fetchChars()
        setupCollectionView()
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    // MARK: - Private Methods
    private func addAllConstraints() {
        let squarePadding: CGFloat = 100
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: squarePadding),
            spinner.heightAnchor.constraint(equalToConstant: squarePadding),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            
        })
    }
}


// MARK: - Extension. RMCharsListViewViewModelDelegate
extension RMCharsListView: RMCharsListViewViewModelDelegate {
    // Initial fetch of characters
    func didLoadInitialChars() {
        spinner.stopAnimating()
        
        collectionView.isHidden = false
        collectionView.reloadData()
                        
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self else { return }
            
            self.collectionView.alpha = 1
        }
    }
}

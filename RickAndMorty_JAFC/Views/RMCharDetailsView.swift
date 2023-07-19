//
//  RMCharDetailsView.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import UIKit


/// Controller to show the info of a single character
final class RMCharDetailsView: UIView {
    // MARK: - Properties
    // MARK: Public Properties
    public var collectionView: UICollectionView?
    
    // MARK: Private properties
    private var viewModel: RMCharDetailsViewViewModel
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    // MARK: - Inits
    init (frame: CGRect, viewModel: RMCharDetailsViewViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPurple
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        
        configConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError ("Unsupported")
    }
    
    
    // MARK: - Private Methods
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIdx, _ in
            return self.createSection(for: sectionIdx)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false  // <<<<<<------ When this is added, the view Shows a black screen
        
        return collectionView
    }
    
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
            
        case .information:
            return viewModel.createInfoSectionLayout()
            
        case .episodes:
            return viewModel.createEpisodesSectionLayout()
        }
    }
    
    
    private func configConstraints() {
        guard let collectionView = collectionView else { return }
        
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
    
    
    // MARK: - Public Methods
    public func config(with viewModel: RMCharDetailsViewViewModel) {
        self.viewModel = viewModel
    }
}

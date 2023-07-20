//
//  RMCharDetailsViewController.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import UIKit


/// Controller to show the details of a selected character
final class RMCharDetailsViewController: UIViewController {
    // MARK: - Properties
    // MARK: Private Properties
    private var viewModel: RMCharDetailsViewViewModel
    private var detailsView: RMCharDetailsView
    
    
    // MARK: - Inits
    init(viewModel: RMCharDetailsViewViewModel) {
        self.viewModel = viewModel
        self.detailsView = RMCharDetailsView(frame: .zero, viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configNavigItem()        
        configConstraints()
        
        detailsView.collectionView?.dataSource = self
        detailsView.collectionView?.delegate = self        
    }
    
    
    // MARK: - Private Methods
    private func configView() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailsView)
    }
    
    
    private func configNavigItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
    }
    
    
    @objc private func didTapShare() {
        // Share character's info
    }
    
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


// MARK: - Extension. UICollectionViewDataSource
extension RMCharDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
            
        case .information(let infoViewModels):
            return infoViewModels.count
            
        case .episodes(let episodesViewModels):
            return episodesViewModels.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharPhotoCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModel)
            
            return cell
            
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharInfoCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            
            return cell
            
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharEpisodesCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharEpisodesCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            
            return cell
        }
    }
}


// MARK: - Extension. UICollectionViewDelegate
extension RMCharDetailsViewController: UICollectionViewDelegate {
    
}

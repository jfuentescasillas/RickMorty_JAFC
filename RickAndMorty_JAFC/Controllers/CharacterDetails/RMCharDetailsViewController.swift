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
        switch section {
        case 0:
            return 1
        
        case 1:
            return 10
        
        case 2:
            return 20
       
        default:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen
        } else {
            cell.backgroundColor = .systemBlue
        }
        
        return cell
    }
}


// MARK: - Extension. UICollectionViewDelegate
extension RMCharDetailsViewController: UICollectionViewDelegate {
    
}

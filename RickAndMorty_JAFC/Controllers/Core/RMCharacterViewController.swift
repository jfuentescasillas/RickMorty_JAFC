//
//  RMCharacterViewController.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import UIKit


/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    // MARK: - Properties
    // MARK: Private Properties
    private let charsListView = RMCharsListView()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    
    // MARK: - Private Methods
    private func configView() {
        charsListView.delegate = self
        
        view.addSubview(charsListView)
        view.backgroundColor = .systemGray4
        
        NSLayoutConstraint.activate([
            charsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charsListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charsListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


// MARK: - Extension. RMCharsListViewDelegate
extension RMCharacterViewController: RMCharsListViewDelegate {
    func rmCharListView(_ charListView: RMCharsListView, didSelectChar character: RMCharacterResult) {
        // Open CharDetailsViewController
        let viewModel = RMCharDetailsViewViewModel(character: character)
        let detailVC = RMCharDetailsViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

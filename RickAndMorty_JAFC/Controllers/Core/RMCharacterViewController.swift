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
    private let charsListView = RMCharsListView()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    
    // MARK: - Private Methods
    private func configView() {
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

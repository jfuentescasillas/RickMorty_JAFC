//
//  RMEpisodeDetailsViewController.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 20/07/23.
//


import UIKit


/// Show the details of a single episode
final class RMEpisodeDetailsViewController: UIViewController {
    // MARK: - Properties
    // MARK: Private Properties
    private let viewModel: RMEpisodeDetailsViewViewModel
    
    
    // MARK: - Inits
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Episode"
        view.backgroundColor = .brown
    }
}

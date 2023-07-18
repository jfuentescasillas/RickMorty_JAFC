//
//  RMCharDetailsViewController.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 18/07/23.
//


import UIKit


/// Controller to show the details of a selected character
class RMCharDetailsViewController: UIViewController {
    // MARK: - Properties
    // MARK: Private Properties
    private var viewModel: RMCharDetailsViewViewModel
    
    // MARK: - Inits
    init(viewModel: RMCharDetailsViewViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray3
        title = viewModel.title
    }
}

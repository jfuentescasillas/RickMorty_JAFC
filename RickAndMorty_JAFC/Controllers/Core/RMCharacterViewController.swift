//
//  RMCharacterViewController.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import UIKit


/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let request = RMRequest(endpoint: .character,
                                queryParams: [
                                    URLQueryItem(name: "name", value: "rick"),
                                    URLQueryItem(name: "status", value: "alive")
                                ])
        print("Request: \(String(describing: request.url))")
        
        RMService.shared.execute(request, expecting: RMCharacterResult.self) { result in
            
        }
    }
}

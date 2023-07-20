//
//  RMEpisodeDetailsViewViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 20/07/23.
//


import UIKit


final class RMEpisodeDetailsViewViewModel {
    // MARK: - Properties
    // MARK: Private Properties
    private let endpointUrl: URL?
    
    
    // MARK: - Inits
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        
        fetchEpisodeData()
    }
    
    
    // MARK: - Private Methods
    private func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url)
        else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            
            case .failure(let failure):
                print(String(describing: failure))
                break
            }
        }
    }
}

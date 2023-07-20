//
//  RMCharEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import Foundation


// MARK: - Protocol
/// Needed to render the data of the episode. RMEpisodeResult will conform to it
protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}


final class RMCharEpisodesCollectionViewCellViewModel {
    // MARK: - Properties
    // MARK: Private Properties
    private let episodeDataURL: URL?
    private var isFetching: Bool = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    private var charEpisode: RMEpisode? {
        didSet {
            guard let model = charEpisode else { return }
            
            dataBlock?(model)
        }
    }
    
    
    // MARK: - Inits
    init (episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
    
    
    // MARK: - Public Methods
    public func fetchEpisode() {
        guard !isFetching else {
            // Manually call the data block and pass in the model
            if let model = charEpisode {
                dataBlock?(model)
            }
            
            return
        }
        
        guard let url = episodeDataURL,
              let request = RMRequest(url: url)
        else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request,
                                 expecting: RMEpisode.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.charEpisode = model
                }
                
            case .failure(let failure):
                print("Failure: \(failure)")
            }
        }
    }
    
    
    public func registerForData(_ block: @escaping(RMEpisodeDataRender) -> Void) {
        dataBlock = block
    }
}

//
//  RMCharsListViewViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import UIKit


protocol RMCharsListViewViewModelDelegate: AnyObject {
    func didLoadInitialChars()
    func didLoadMoreChars(newIndexPaths: [IndexPath])
    func didSelectChar(_ character: RMCharacterResult)
}


/// This viewModel controls the character list view logic
final class RMCharsListViewViewModel: NSObject {
    // MARK: - Properties
    // MARK: Public Properties
    public weak var delegate: RMCharsListViewViewModelDelegate?
    
    // Allows Pagination if more characters are available
    public var shouldLoadMoreCharsAndShowIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    // MARK: Private Properties
    private var cellViewModels = [RMCharsCollectionViewCellViewModel]()
    private var apiInfo: RMGetAllCharsResponse.RMGetAllCharsInfo? = nil  // Used in Pagination
    private var isLoadingMoreChars: Bool = false  // Used in Pagination
    private var charsList: [RMCharacterResult] = [] {
        didSet {
            let newViewModels = charsList.map { character in
                let newModel = RMCharsCollectionViewCellViewModel(
                    charName: character.name,
                    charStatus: character.status,
                    charImgURL: URL(string: character.image)
                )
                
                return newModel
            }
            
            let existingViewModels = cellViewModels
            let uniqueViewModels   = newViewModels.filter { !existingViewModels.contains($0) }
            
            cellViewModels.append(contentsOf: uniqueViewModels)
            
            // Uncomment to see behavior (it is related to the Hashable and Equatable in RMCharsCollectionViewCellViewModel
            /* print("newViewModels: \(newViewModels)")
            print("newViewModels counter: \(newViewModels.count)\n")
            
            print("cellViewModels before filter: \(cellViewModels)")
            print("cellViewModels before filter counter: \(cellViewModels.count)\n")
            
            let existingViewModels = cellViewModels
            print("ExistingViewModels: \(existingViewModels)")
            print("ExistingViewModels counter: \(existingViewModels.count)\n")
            
            let uniqueViewModels   = newViewModels.filter { !existingViewModels.contains($0) }
            print("uniqueViewModels: \(uniqueViewModels)")
            print("uniqueViewModels counter: \(uniqueViewModels.count)\n")
            
            cellViewModels.append(contentsOf: uniqueViewModels)
            print("cellViewModels after filter: \(cellViewModels)")
            print("cellViewModels after filter counter: \(cellViewModels.count)\n")
            
            print("Summary:")
            print("newViewModels counter: \(newViewModels.count)")
            print("cellViewModels before filter counter: \(cellViewModels.count)")
            print("ExistingViewModels counter: \(existingViewModels.count)")
            print("uniqueViewModels counter: \(uniqueViewModels.count)")
            print("cellViewModels after filter counter: \(cellViewModels.count)")
            print("-----------------\n") */
        }
    }
        
    
    // MARK: - Public Methods
    /// Fetch the initial batch of characters (20 chars by default)
    public func fetchChars() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharsResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                
                self.charsList = results
                self.apiInfo = info
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialChars()
                }                
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    /// When using Pagination, fetch other 20 chars by default (if available)
    public func fetchMoreChars(url: URL) {
        guard !isLoadingMoreChars else { return }
        
        isLoadingMoreChars = true
            
        guard let request = RMRequest(url: url) else {
            isLoadingMoreChars = false
            
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMGetAllCharsResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                self.apiInfo = info
                
                let originalCount = self.charsList.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIdx = total - newCount
                let idxPathToAdd: [IndexPath] = Array(startingIdx..<(startingIdx+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                
                self.charsList.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreChars(newIndexPaths: idxPathToAdd)
                }
                          
                self.isLoadingMoreChars = false
                
            case .failure(let failure):
                print("The failure is: \(String(describing: failure))")
                
                self.isLoadingMoreChars = false
            }
        }
    }
}


// MARK: - Extension. CollectionViewDataSource
extension RMCharsListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharCollectionViewCell.cellIdentifier,
            for: indexPath) as? RMCharCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
        
    // Used for the activity indicator at the end of the collection view (the footer) when Pagination is activated
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                  for: indexPath
              ) as? RMFooterLoadingCollectionReusableView
        else {
            return UICollectionReusableView()
        }
        
        footer.startAnimating()
        
        return footer
    }}


// MARK: - Extension. CollectionViewDelegate
extension RMCharsListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let charSelected = charsList[indexPath.row]
        delegate?.didSelectChar(charSelected)
    }
}


// MARK: - Extension. UICollectionViewDelegateFlowLayout
extension RMCharsListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width  = (bounds.width - 30) / 2
        let size   = CGSize(width: width, height: width * 1.5)
        
        return size
    }
    
    
    // This is the area where the activity indicator will be displayed when the pagination is activated
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldLoadMoreCharsAndShowIndicator else {
            return .zero  // Hide the footer
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}


// MARK: - Extension. UIScrollViewDelegate
extension RMCharsListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldLoadMoreCharsAndShowIndicator,
              !isLoadingMoreChars,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }
        
        // Used in the pagination to fetch more characters (if available)
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] time in
            guard let self else { return }
            
            let offset                     = scrollView.contentOffset.y  // y coordinate (up and down)
            let totalContentHeight         = scrollView.contentSize.height  // The entire scrollview, if there are 5,000 characters, it'll be very tall
            let totalScrollViewFixedHEight = scrollView.frame.size.height  // Screen's height, usually a fixed (the same) value.
            
            if offset >= (totalContentHeight - totalScrollViewFixedHEight - 110) {
                // print("Fetch more characters")
                self.fetchMoreChars(url: url)
            }
            
            time.invalidate()
        }
    }
}

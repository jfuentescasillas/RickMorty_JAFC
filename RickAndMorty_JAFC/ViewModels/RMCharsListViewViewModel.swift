//
//  RMCharsListViewViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 17/07/23.
//


import UIKit


protocol RMCharsListViewViewModelDelegate: AnyObject {
    func didLoadInitialChars()
}


final class RMCharsListViewViewModel: NSObject {
    // MARK: - Properties
    public weak var delegate: RMCharsListViewViewModelDelegate?
    
    private var charsList = [RMCharacterResult]() {
        didSet {
            cellViewModels = charsList.map { char in
                let viewModel = RMCharsCollectionViewCellViewModel(
                    charName: char.name,
                    charStatus: char.status ?? .unknown,
                    charImgURL: URL(string: char.image)
                )
                
                return viewModel
            }
            /* Initial version:
             for char in charsList {
                let viewModel = RMCharsCollectionViewCellViewModel(
                    charName: char.name,
                    charStatus: char.status ?? .unknown,
                    charImgURL: URL(string: char.image)
                )
                
                cellViewModels.append(viewModel)
            } */
        }
    }
    
    private var cellViewModels = [RMCharsCollectionViewCellViewModel]()
    
    
    // MARK: - Public Methods
    public func fetchChars() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharsResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self.charsList = results
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialChars()
                }                
                
            case .failure(let error):
                print(String(describing: error))
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RMCharCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
}


// MARK: - Extension. CollectionViewDelegate
extension RMCharsListViewViewModel: UICollectionViewDelegate {
    
}


// MARK: - Extension. UICollectionViewDelegateFlowLayout
extension RMCharsListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width  = (bounds.width - 30) / 2
        let size   = CGSize(width: width, height: width * 1.5)
        
        return size
    }
}

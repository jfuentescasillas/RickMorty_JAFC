//
//  RMCharInfoCollectionViewCellViewModel.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 19/07/23.
//


import UIKit


final class RMCharInfoCollectionViewCellViewModel {
    //MARK: - Enums
    enum CharacterType: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemMint
            case .episodeCount:
                return .systemYellow
            }
        }
        
        var iconImg: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "person")
            case .gender:
                return UIImage(systemName: "person")
            case .type:
                return UIImage(systemName: "person")
            case .species:
                return UIImage(systemName: "person")
            case .origin:
                return UIImage(systemName: "person")
            case .created:
                return UIImage(systemName: "person")
            case .location:
                return UIImage(systemName: "person")
            case .episodeCount:
                return UIImage(systemName: "person")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status, .gender, .type,
                    .species, .origin,
                    .created, .location:
                return rawValue.uppercased()
                
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    // MARK: - Properties
    // MARK: Public Properties
    public var title: String {
        return charType.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {
            return "Not Available"
        }
        
        if let date = Self.dateFormatter.date(from: value),
           charType == .created {
            let shortDate = Self.shortDateFormatter.string(from: date)
            
            return shortDate
        }
        
        return value
    }
    
    public var iconImage: UIImage? {
        return charType.iconImg
    }
    
    public var tintColor: UIColor {
        return charType.tintColor
    }
    
    // MARK: Private Properties
    private let charType: CharacterType
    private let value: String
    static private let dateFormatter: DateFormatter = {
        // 2017-11-04T18:50:21.651Z
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    static private let shortDateFormatter: DateFormatter = {
        // 2017-11-04T18:50:21.651Z
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    // MARK: - Inits
    init (charType: CharacterType, value: String) {
        self.charType = charType
        self.value = value
    }
}

//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit

class DetailsView: BaseChildView {

    // MARK: -
    // MARK: Public
    
    func configure(model: [Period]) {
        
    }
    
    enum Section: Int, CaseIterable {
        case list
        case grid
        case grid2

        var columnCount: Int {
            switch self {
            case .grid:
                return 1
            case .list:
                return 2
            case .grid2:
                return 2
            }
        }
    }
    
    func compositionalLayoutConfigure() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let columns = sectionKind.columnCount

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

            let groupHeight = columns == 1 ?
                NSCollectionLayoutDimension.estimated(180) :
                NSCollectionLayoutDimension.fractionalWidth(0.3)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(16)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
        
        self.collectionView.collectionViewLayout = layout
    }
}

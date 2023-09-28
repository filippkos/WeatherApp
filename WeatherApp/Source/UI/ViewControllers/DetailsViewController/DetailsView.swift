//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit

enum SectionType {
    case conditions
    case infographics
}

enum ItemType {
    case condition
    case hourlyForecast
    case lineChart
}

struct DetailsSection: Hashable {
    let type: SectionType
    let items: [DetailsItem]
}

struct DetailsItem: Hashable {
    let type: ItemType
    let title: String
}

final class DetailsView: BaseChildView {
    
    // MARK: -
    // MARK: Localization
    
    typealias Loc = L10n.DetailsView
    
    // MARK: -
    // MARK: Variables
    
    var sections: [DetailsSection] = []

    // MARK: -
    // MARK: Public
    
    func setup() {
        self.collectionView.collectionViewLayout = self.createCompositionalLayout()
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    func configure() {
        
        self.sections.append(DetailsSection(type: .conditions, items: [
            DetailsItem(type: .condition, title: Loc.windSpeedTitle),
            DetailsItem(type: .condition, title: Loc.rainChanceTitle),
            DetailsItem(type: .condition, title: Loc.pressureTitle),
            DetailsItem(type: .condition, title: Loc.humidityTitle)
        ]))
        self.sections.append(DetailsSection(type: .infographics, items: [
            DetailsItem(type: .hourlyForecast, title: Loc.hourlyForecastTitle),
            DetailsItem(type: .lineChart, title: Loc.lineChartTitle),
            DetailsItem(type: .lineChart, title: "Empty Cell"),
            DetailsItem(type: .lineChart, title: "Empty Cell2")
        ]))
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
           
            switch section.type {
            case .conditions:
                return self.createConditionsSection()
            case .infographics:
                return self.createInfographicsSection()
            }
        }
        
        return layout
    }
    
    func createConditionsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createInfographicsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

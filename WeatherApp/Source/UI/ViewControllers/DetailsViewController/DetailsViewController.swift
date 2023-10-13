//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit
import RxSwift
import SnapKit

struct DetailsSection: Hashable {
    let type: SectionType
    let items: [DetailsItem]
}

enum SectionType: CaseIterable {
    case conditions
    case infographics
    
    var cellType: UICollectionViewCell.Type {
        switch self {
        case .conditions:
            return DetailsConditionCollectionViewCell.self
        case .infographics:
            return DetailsInfographicsCollectionViewCell.self
        }
    }
}

struct DetailsItem: Hashable {
    var type: ItemType
}


enum ItemType: Hashable {
    case condition(type: ConditionsItemType)
    case infographic(type: InfographicItemType)
    
    enum ConditionsItemType: CaseIterable {
        case windSpeed
        case rainVolume
        case pressure
        case humidity
        
        typealias Loc = L10n.DetailsView
        
        var title: String {
            switch self {
            case .windSpeed:
                return Loc.windSpeedTitle
            case .rainVolume:
                return Loc.rainVolumeTitle
            case .pressure:
                return Loc.pressureTitle
            case .humidity:
                return Loc.humidityTitle
            }
        }
        
        var image: String {
            switch self {
            case .windSpeed:
                return "wind"
            case .rainVolume:
                return "cloud.rain"
            case .pressure:
                return "water.waves"
            case .humidity:
                return "drop"
            }
        }
    }
    
    enum InfographicItemType: CaseIterable {
        case hourlyForecast
        case lineChart
        
        typealias Loc = L10n.DetailsView
        
        var title: String {
            switch self {
            case .hourlyForecast:
                return Loc.hourlyForecastTitle
            case .lineChart:
                return Loc.lineChartTitle
            }
        }
        
        var image: String {
            switch self {
            case .hourlyForecast:
                return "clock"
            case .lineChart:
                return "chart.line.uptrend.xyaxis"
            }
        }
    }
}

final class DetailsViewController: BaseChildController, RootViewGettable {
    
    // MARK: -
    // MARK: RootView

    typealias RootView = DetailsView
    typealias Registration = UICollectionView.CellRegistration
    
    typealias ConditionCellRegistration = Registration<DetailsConditionCollectionViewCell, [Period]>
    typealias InfographicCellRegistration = Registration<DetailsInfographicsCollectionViewCell, [Period]>
    
    // MARK: -
    // MARK: Variables
    
    var days: [[Period]] = []
    var dataSource: UICollectionViewDiffableDataSource<DetailsSection, DetailsItem>?
    
    private let dispose = DisposeBag()
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView?.collectionView.registerDefaultCell(cellClass: DetailsInfographicsCollectionViewCell.self)
        self.rootView?.collectionView.registerDefaultCell(cellClass: DetailsConditionCollectionViewCell.self)
        self.rootView?.configure()
        self.rootView?.setup()
        self.createDataSource()
        self.reloadData()
        self.bind()
    }

    func createDataSource() {
        let conditionCellRegistration = self.conditionCellRegistration()
        let infographicCellRegistration = self.infographicCellRegistration()
        
        self.dataSource = UICollectionViewDiffableDataSource<DetailsSection, DetailsItem>(collectionView: self.rootView?.collectionView ?? UICollectionView(), cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch self.rootView?.sections[indexPath.section].type {
            case .conditions:
                let item = self.rootView?.sections[indexPath.section].items[indexPath.row]
                let cell = collectionView.dequeueConfiguredReusableCell(using: conditionCellRegistration, for: indexPath, item: [])
                let conditionView = ConditionView()
                conditionView.configure(value: self.averageValue(day: self.storage.selectedDay.value, item: item))
                cell.configure(with: self.title(item: item), image: self.image(item: item))
                cell.configure(with: conditionView)
                
                return cell
            case .infographics:
                let item = self.rootView?.sections[indexPath.section].items[indexPath.row]
                switch item?.type {
                case .some(.infographic(.hourlyForecast)):
                    let cell = collectionView.dequeueConfiguredReusableCell(using: infographicCellRegistration, for: indexPath, item: [])
                    let hourlyForecastView = HourlyForecastView()
                    cell.configure(with: self.title(item: item), image: self.image(item: item))
                    cell.configure(with: hourlyForecastView)
                    hourlyForecastView.setup(for: self.storage.selectedDay.value)
                
                    return cell
                case .some(.infographic(.lineChart)):
                    let cell = collectionView.dequeueConfiguredReusableCell(using: infographicCellRegistration, for: indexPath, item: [])
                    let lineGraphView = LineGraphForecastView()
                    lineGraphView.configure(day: self.storage.selectedDay.value)
                    cell.configure(with: self.title(item: item), image: self.image(item: item))
                    cell.configure(with: lineGraphView)
                    
                    return cell
                case .some(.condition):
                    return nil
                case .none:
                    return nil
                }
            case .none:
                return nil
            }
        })
    }
    
    private func title(item: DetailsItem?) -> String {
        guard let item else { return "" }
        
        switch item.type {
        case .condition(type: let type):
            return type.title
        case .infographic(type: let type):
            return type.title
        }
    }
    
    private func image(item: DetailsItem?) -> String {
        guard let item else { return "" }
        
        switch item.type {
        case .condition(type: let type):
            return type.image
        case .infographic(type: let type):
            return type.image
        }
    }
    
    private func averageValue(day: [Period], item: DetailsItem?) -> Double {
        guard let item else { return 0 }
        
        switch item.type {
        case .condition(type: let type):
            switch type {
            case .windSpeed:
                return round((day.map {
                    $0.wind.speed
                }.reduce(0, +)) / Double(day.count))
            case .rainVolume:
                return (day.map {
                    $0.rain?.the3H ?? 0
                }.reduce(0, +)) / Double(day.count)
            case .pressure:
                return round((day.map {
                    Double($0.main.pressure)
                }.reduce(0, +)) / Double(day.count))
            case .humidity:
                return round((day.map {
                    Double($0.main.humidity)
                }.reduce(0, +)) / Double(day.count))
            }
        case .infographic(type: _):
            return 0
        }
    }

    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailsSection, DetailsItem>()
        snapshot.appendSections(self.rootView?.sections ?? [])

        for section in self.rootView?.sections ?? [] {
            snapshot.appendItems(section.items, toSection: section)
        }

        self.dataSource?.apply(snapshot)
    }
    
    func bind() {
        self.storage.list.bind { [weak self] in
            self?.days = $0.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount(model: $0) ?? 0)
        }
        .disposed(by: self.dispose)
        
        self.storage.selectedDay.bind { [weak self] _ in
            self?.rootView?.collectionView.reloadData()
        }
        .disposed(by: self.dispose)
    }
    
    func getTodayPeriodsCount(model: [Period]) -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(model.first?.dt ?? 0))
        let hours = DateFormatter.custom(format: .time(withOnly: .hours)).string(from: date as Date)
        
        return (24 - (Int(hours) ?? 0)) / 3
    }
    
    private func conditionCellRegistration() -> ConditionCellRegistration {
        return ConditionCellRegistration { cell, indexPath, itemIdentifier in
        }
    }
    
    private func infographicCellRegistration() -> InfographicCellRegistration {
        return InfographicCellRegistration {cell, indexPath, itemIdentifier in
        }
    }
}

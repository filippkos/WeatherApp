//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit
import RxSwift
import SnapKit

final class DetailsViewController: BaseChildController, RootViewGettable {
    
    // MARK: -
    // MARK: RootView
    
    typealias RootView = DetailsView
    
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
        self.dataSource = UICollectionViewDiffableDataSource<DetailsSection, DetailsItem>(collectionView: self.rootView?.collectionView ?? UICollectionView(), cellProvider: { collectionView, indexPath, itemIdentifier in
            switch self.rootView?.sections[indexPath.section].type {
            case .conditions:
                let item = self.rootView?.sections[indexPath.section].items[indexPath.row]
                let cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: DetailsConditionCollectionViewCell.self, indexPath: indexPath) ?? DetailsConditionCollectionViewCell()
                cell.container.subviews.forEach({ $0.removeFromSuperview() })
                let conditionView = ConditionView()
                conditionView.configure()
                cell.container.addSubview(conditionView)
                conditionView.snp.makeConstraints {
                    $0.left.right.top.bottom.equalToSuperview()
                }
                cell.configure(with: item?.title ?? "")
                return cell
            case .infographics:
                let item = self.rootView?.sections[indexPath.section].items[indexPath.row]
                switch item?.type {
                case .some(.hourlyForecast):
                    let cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: DetailsInfographicsCollectionViewCell.self, indexPath: indexPath) ?? DetailsInfographicsCollectionViewCell()
                    cell.container.subviews.forEach({ $0.removeFromSuperview() })
                    let hourlyForecastView = HourlyForecastView()
                    hourlyForecastView.setup(for: self.storage.selectedDay.value)
                    cell.container.addSubview(hourlyForecastView)
                    hourlyForecastView.snp.makeConstraints {
                        $0.left.right.top.bottom.equalToSuperview()
                    }
                    hourlyForecastView.reloadData()
                    cell.configure(with: item?.title ?? "")
                    return cell
                case .some(.lineChart):
                    let cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: DetailsInfographicsCollectionViewCell.self, indexPath: indexPath) ?? DetailsInfographicsCollectionViewCell()
                    cell.container.subviews.forEach({ $0.removeFromSuperview() })
                    let lineGraphView = LineGraphForecastView()
                    cell.container.addSubview(lineGraphView)
                    lineGraphView.configure(day: self.storage.selectedDay.value)
                    lineGraphView.snp.makeConstraints {
                        $0.left.right.top.bottom.equalToSuperview()
                    }
                    cell.configure(with: item?.title ?? "")
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
}

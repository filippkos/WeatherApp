//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit
import RxSwift
import SnapKit

class DetailsViewController: BaseChildController, UICollectionViewDataSource, UICollectionViewDelegate, RootViewGettable {
    
    // MARK: -
    // MARK: RootView
    
    typealias RootView = DetailsView
    
    // MARK: -
    // MARK: Variables
    
    var days: [[Period]] = []
    
    private let dispose = DisposeBag()
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView.dataSource = self
        self.rootView?.collectionView.delegate = self
        self.rootView?.collectionView.registerDefaultCell(cellClass: DetailsCollectionViewCell.self)
        self.rootView?.compositionalLayoutConfigure()
        self.rootView?.collectionView.showsVerticalScrollIndicator = false
        self.bind()
    }
    
    func bind() {
        self.list.bind { [weak self] in
            self?.days = $0.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount(model: $0) ?? 0)
        }
        .disposed(by: self.dispose)
        
        self.parentController?.selectedDay.bind { [weak self] _ in
            self?.rootView?.collectionView.reloadData()
        }
        .disposed(by: self.dispose)
    }
    
    func getTodayPeriodsCount(model: [Period]) -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(model.first?.dt ?? 0))
        let hours = DateFormatter.customDateFormatter(format: .time(withOnly: .hours)).string(from: date as Date)
        
        return (24 - (Int(hours) ?? 0)) / 3
    }
    
    // MARK: -
    // MARK: UITableView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: DetailsCollectionViewCell
        cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: DetailsCollectionViewCell.self, indexPath: indexPath) ?? DetailsCollectionViewCell()
        cell.titleLabel.text = "Hourly forecast"
        
        if indexPath == IndexPath(row: 0, section: 1) {
            cell.container.subviews.forEach({ $0.removeFromSuperview() })
            let hourlyForecastView = HourlyForecastView()
            hourlyForecastView.setup(for: self.parentController?.selectedDay.value ?? [])
            cell.container.addSubview(hourlyForecastView)
            hourlyForecastView.snp.makeConstraints {
                $0.left.right.top.bottom.equalToSuperview()
            }
            hourlyForecastView.reloadData()
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
}

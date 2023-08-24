//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastViewController: BaseChildController, UICollectionViewDataSource, UICollectionViewDelegate, RootViewGettable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = ForecastView
    
    // MARK: -
    // MARK: Variables
    
    var city: String = ""
    var id: String = ""
    var days: [[Period]] = []

    private let dispose = DisposeBag()
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView.dataSource = self
        self.rootView?.collectionView.delegate = self
        self.rootView?.collectionView.registerDefaultCell(cellClass: ForecastCollectionViewCell.self)
        self.rootView?.collectionView.showsVerticalScrollIndicator = false
        self.rootView?.flowLayoutListConfigure()
        self.bind()
    }
    
    func bind() {
        self.list.bind { [weak self] in
            self?.days = $0.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount(model: $0) ?? 0)
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
        self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ForecastCollectionViewCell
        cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: ForecastCollectionViewCell.self, indexPath: indexPath) ?? ForecastCollectionViewCell()
        cell.configure(day: self.days[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.parentController?.selectedDay.accept(self.parentController?.days[indexPath.row] ?? [])
        self.parentController?.showChildController(.details)
    }
}

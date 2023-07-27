//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 24.07.2023.
//

import UIKit

class HourlyForecastView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var numberOfCards: Int = 8
    var arrayOfViews: [UIView] = []
    var model: HourlyForecastCellModel?
    let layout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: CGRect(), collectionViewLayout: layout)
        
        self.registerDefaultCell(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.registerDefaultCell(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
    }
    
    func setup(model: ForecastModel) {
        model.list.forEach { _ in
            
        }
    }
    
    func prepareViews() {
        for _ in 0...self.numberOfCards {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HourlyForecastViewCell()
       // cell.configure(model: <#T##HourlyForecastCellModel#>)
        
        return cell
    }
}

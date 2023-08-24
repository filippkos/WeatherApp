//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

class ForecastView: BaseChildView {
    
    // MARK: -
    // MARK: Public
    
    func flowLayoutListConfigure() {
        let itemWidth = (self.collectionView?.frame.size.width ?? 0) - 56
        let itemHeight = self.collectionView?.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: itemWidth, height: 84)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.alwaysBounceVertical = true
    }
}

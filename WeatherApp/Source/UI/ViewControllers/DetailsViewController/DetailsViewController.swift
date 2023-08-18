//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit

class DetailsViewController: BaseChildController, UICollectionViewDataSource, UICollectionViewDelegate, RootViewGettable {
    
    // MARK: -
    // MARK: RootView
    
    typealias RootView = DetailsView
    
    // MARK: -
    // MARK: Variables
    
    var days: [[Period]] = []
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView.dataSource = self
        self.rootView?.collectionView.delegate = self
        self.rootView?.collectionView.registerDefaultCell(cellClass: DetailsCollectionViewCell.self)
        self.navigationController?.navigationBar.isHidden = true
        self.rootView?.compositionalLayoutConfigure()
    }
    
    // MARK: -
    // MARK: UITableView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: DetailsCollectionViewCell
        cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: DetailsCollectionViewCell.self, indexPath: indexPath) ?? DetailsCollectionViewCell()
        cell.titleLabel.text = "sdf"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}

//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

class ForecastViewController: UIViewController, UITableViewDataSource, RootViewGettable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = ForecastView
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.tableView.dataSource = self
        self.rootView?.tableView.register(cellClass: ForecastTableViewCell.self)
        
    }
    
    // MARK: -
    // MARK: UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: ForecastTableViewCell.self)
        cell.label.text = "1234"
        
        return cell
    }
    
}

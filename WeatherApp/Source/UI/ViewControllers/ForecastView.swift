//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

class ForecastView: UIView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    func configure(city: String) {
        self.cityNameLabel.text = city
    }
}

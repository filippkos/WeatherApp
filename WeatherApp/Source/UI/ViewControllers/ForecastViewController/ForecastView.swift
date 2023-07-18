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
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var minMaxLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    func configure(model: ForecastModel) {
        self.cityNameLabel.text = model.city.name
        self.temperatureLabel.text = "+25°"
        self.weatherLabel.text = model.list.first?.weather.first?.main.rawValue
    }
    
    func changeLabels() {
        UIView.animate(withDuration: 0.5) {
            self.temperatureLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
       //     self.temperatureLabel.transform = CGAffineTransform(translationX: 10, y: 50)
            self.temperatureLabel.transform = CGAffineTransform(rotationAngle: 0)
         }
    }
}

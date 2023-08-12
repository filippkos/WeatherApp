//
//  HourlyForecastViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 24.07.2023.
//

import UIKit
import SwiftUI

class HourlyForecastViewCell: UICollectionViewCell {

    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var weatherIcon: UIImageView?
    @IBOutlet var temperatureLabel: UILabel?
    
    func configure(period: Period, image: UIImage) {
        self.timeLabel?.text = TimeConverter.getStringTime(from: period.dt)
        self.temperatureLabel?.text = TemperatureConverter.stringCelsius(from: period.main.temp).description
        self.weatherIcon?.image = image
    }
    
    func getWeatherImage(period: Period) -> UIImage {
        switch period.weather[0].main {
        case .clear:
            return Images.sunny.image
        case .clouds:
            return Images.cloudy.image
        case .rain:
            return Images.rain.image
        }
    }
}

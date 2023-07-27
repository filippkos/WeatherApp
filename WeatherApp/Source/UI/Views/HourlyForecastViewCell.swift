//
//  HourlyForecastViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 24.07.2023.
//

import UIKit

struct HourlyForecastCellModel {
    let time: Double = 0
    let icon: UIImage? = nil
    let temperature: Int = 0
}

class HourlyForecastViewCell: UICollectionViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    
    func configure(model: HourlyForecastCellModel) {
        
    }
}

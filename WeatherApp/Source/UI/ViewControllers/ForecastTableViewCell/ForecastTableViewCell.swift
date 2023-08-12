//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: Localization
    
    typealias loc = L10n.ForecastTableCell
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tempTitleLabel: UILabel!
    @IBOutlet var tempValueLabel: UILabel!
    @IBOutlet var minTempTitleLabel: UILabel!
    @IBOutlet var minTempValueLabel: UILabel!
    @IBOutlet var maxTempTitleLabel: UILabel!
    @IBOutlet var maxTempValueLabel: UILabel!
    
    // MARK: -
    // MARK: Public
    
    func configure(model: Period) {
        self.timeLabel.text = TimeConverter.getStringTime(from: model.dt)
        self.tempTitleLabel.text = loc.temperature
        self.tempValueLabel.text = TemperatureConverter.stringCelsius(from: model.main.temp)
        self.minTempTitleLabel.text = loc.min
        self.minTempValueLabel.text = TemperatureConverter.stringCelsius(from: model.main.tempMin)
        self.maxTempTitleLabel.text = loc.max
        self.maxTempValueLabel.text = TemperatureConverter.stringCelsius(from: model.main.tempMax)
    }
}

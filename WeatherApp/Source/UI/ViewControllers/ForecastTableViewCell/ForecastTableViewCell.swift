//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
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
    
    func configure(model: List) {
        self.timeLabel.text = self.getTime(time: TimeInterval(model.dt))
        self.tempTitleLabel.text = "Temperature"
        self.tempValueLabel.text = self.convert(temp: model.main.temp)
        self.minTempTitleLabel.text = "Min"
        self.minTempValueLabel.text = self.convert(temp: model.main.tempMin)
        self.maxTempTitleLabel.text = "Max"
        self.maxTempValueLabel.text = self.convert(temp: model.main.tempMax)
    }
    
    func getTime(time: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date as Date)
        
        return localDate
    }
    
    func convert(temp: Double) -> String {
        return "+\(Int(temp - 273).description)"
    }
}

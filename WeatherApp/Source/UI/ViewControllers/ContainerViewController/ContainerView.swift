//
//  ContainerView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit

class ContainerView: UIView {

    // MARK: Localization
    
    typealias loc = L10n.ContainerView
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var textFieldView: SearchTextFieldView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var todayButton: UIButton!
    @IBOutlet var tomorrowButton: UIButton!
    @IBOutlet var forecastButton: UIButton!
    @IBOutlet var contentView: UIView!

    func configureDefault(cityName: String, selectedDay: [Period]) {
        self.temperatureLabel.text = TemperatureConverter.stringCelsius(from: selectedDay.first?.main.temp ?? 0)
        self.weatherLabel.text = selectedDay.first?.weather.first?.main.rawValue ?? ""
        self.configureButtons()
    }
    
    func configureButtons() {
        self.todayButton.layer.cornerRadius = 8
        self.tomorrowButton.layer.cornerRadius = 8
        self.forecastButton.layer.cornerRadius = 8
        self.todayButton.backgroundColor = Colors.cellBackgroundGreen.color
        self.tomorrowButton.backgroundColor = Colors.cellBackgroundGreen.color
        self.forecastButton.backgroundColor = Colors.cellBackgroundGreen.color
        self.todayButton.tintColor = .black
        self.tomorrowButton.tintColor = .black
        self.forecastButton.tintColor = .black
        self.todayButton.setTitle(loc.today, for: .normal)
        self.tomorrowButton.setTitle(loc.tomorrow, for: .normal)
        self.forecastButton.setTitle(loc.forecast, for: .normal)
    }

    func changeLabels() {
        UIView.animate(withDuration: 0.5) {
            self.temperatureLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
       //     self.temperatureLabel.transform = CGAffineTransform(translationX: 10, y: 50)
            self.temperatureLabel.transform = CGAffineTransform(rotationAngle: 0)
         }
    }
}

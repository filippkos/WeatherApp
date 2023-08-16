//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

class ForecastView: UIView {
    
    // MARK: -
    // MARK: Localization
    
    typealias loc = L10n.ForecastView
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var textFieldView: SearchTextFieldView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var todayButton: UIButton!
    @IBOutlet var tomorrowButton: UIButton!
    @IBOutlet var forecastButton: UIButton!
    @IBOutlet var hourlyForecastView: HourlyForecastView!

    func configureDefault(cityName: String, selectedDay: [Period]) {
        self.temperatureLabel.text = TemperatureConverter.stringCelsius(from: selectedDay.first?.main.temp ?? 0)
        self.weatherLabel.text = selectedDay.first?.weather.first?.main.rawValue ?? ""
        self.hourlyForecastView.setup(for: selectedDay)
        self.configureButtons()
    }
    
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
    
    func configureButtons() {
        self.todayButton.layer.cornerRadius = 8
        self.tomorrowButton.layer.cornerRadius = 8
        self.forecastButton.layer.cornerRadius = 8
        self.todayButton.backgroundColor = Colors.cellBackgroundGreen.color
        self.tomorrowButton.backgroundColor = Colors.cellBackgroundGreen.color
        self.forecastButton.backgroundColor = Colors.cellBackgroundGreen.color
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

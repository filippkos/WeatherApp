//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 15.08.2023.
//

import UIKit
import SnapKit

final class ForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    var timeLabel = UILabel()
    var weatherImage = UIImageView()
    var weatherLabel = UILabel()
    var minTempValueLabel = UILabel()
    var maxTempValueLabel = UILabel()
    
    var mainStackView = UIStackView()
    var infoStackView = UIStackView()
    var tempStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = Colors.cellBackgroundGreen.color
        self.layer.cornerRadius = 18
        self.addViews()
        self.addConstraints()
    }
    
    func addViews() {
        self.mainStackView.axis = .horizontal
        self.infoStackView.axis = .vertical
        self.tempStackView.axis = .vertical
        self.mainStackView.distribution = .fillProportionally
        self.infoStackView.distribution = .fillEqually
        self.tempStackView.distribution = .fillEqually
        self.addSubview(self.mainStackView)
        self.mainStackView.addArrangedSubview(self.infoStackView)
        self.mainStackView.addArrangedSubview(self.tempStackView)
        self.mainStackView.addArrangedSubview(self.weatherImage)
        self.infoStackView.addArrangedSubview(self.timeLabel)
        self.infoStackView.addArrangedSubview(self.weatherLabel)
        self.tempStackView.addArrangedSubview(self.maxTempValueLabel)
        self.tempStackView.addArrangedSubview(self.minTempValueLabel)
        self.minTempValueLabel.textAlignment = .right
        self.maxTempValueLabel.textAlignment = .right
        self.minTempValueLabel.font = Fonts.SFProDisplay.regular.font(size: 16)
        self.maxTempValueLabel.font = Fonts.SFProDisplay.regular.font(size: 16)
        self.timeLabel.font = Fonts.SFProDisplay.regular.font(size: 16)
        self.weatherLabel.font = Fonts.SFProDisplay.regular.font(size: 16)
    }
    
    func addConstraints() {
        self.mainStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(18)
            $0.top.bottom.equalToSuperview().inset(15)
        }
        self.weatherImage.snp.makeConstraints {
            $0.width.height.equalTo(54)
        }
    }
    
    func configure(day: [Period]) {
        self.timeLabel.text = TimeConverter.getStringDate(from: day.first?.dt ?? 0)
        self.weatherLabel.text = self.mostCommonWeather(from: day)?.main.rawValue ?? ""
        self.minTempValueLabel.text = TemperatureConverter.stringCelsius(from: minTemperature(from: day))
        self.maxTempValueLabel.text = TemperatureConverter.stringCelsius(from: maxTemperature(from: day))
        self.weatherImage(weather: self.mostCommonWeather(from: day)!)
    }
    
    func maxTemperature(from day: [Period]) -> Double {
        return day.max { $0.main.tempMax < $1.main.tempMax }?.main.tempMax ?? 0.0
    }
    
    func minTemperature(from day: [Period]) -> Double {
        return day.min { $0.main.tempMax < $1.main.tempMax }?.main.tempMax ?? 0.0
    }
    
    func mostCommonWeather(from day: [Period]) -> Weather? {
        let mappedItems = day.map { ($0.weather.first, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        let mostCommon = counts.max { $0.1 < $1.1 }?.key

        return mostCommon
    }
    
    func weatherImage(weather: Weather) {
        let icon = weather.icon
        let endPoint = icon + "@2x.png"
        let requestModel = NetworkRequestModel(requestType: .image, endPoint: endPoint, httpMethod: .get)

        NetworkManager.image(requestModel: requestModel) { [weak self] (result: Result<Data, Error>) in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.weatherImage.image = image
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

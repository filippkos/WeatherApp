//
//  LineGraphForecastView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 28.08.2023.
//

import UIKit
import SnapKit

@IBDesignable
final class LineGraphForecastView: UIView {
    
    private let xAxisView = XAxisView()
    private let yAxisView = YAxisView()
    private let gridView = GridView()
    private var mainStack = UIStackView()
    private var topStack = UIStackView()
    private var bottomStack = UIStackView()
    private let spacer = UIView()

    init() {
        super.init(frame: CGRect())
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    func setup() {
        self.prepareView()
    }
    
    func configure(day: [Period]) {

        let temps = day.map { TemperatureConverter.roundedDoubleCelsius(from: $0.main.temp) }
        
        let roundedMaxTemp = 10 * (ceil((temps.max() ?? 0) / 10) + 1)
        let roundedMinTemp = 10 * (floor((temps.max() ?? 0) / 10) - 1)
        
        var yAxisData: [String] = []
        var buffer = Int(roundedMinTemp)
        
        (Int(roundedMinTemp / 10)...Int(roundedMaxTemp / 10)).forEach { _ in
            yAxisData.append(Int(buffer).description)
            buffer += 10
        }
        yAxisData = yAxisData.reversed()
        
        self.yAxisView.configure(data: yAxisData)
        
        self.gridView.configure(data: temps, min: roundedMinTemp, max: roundedMaxTemp, num: yAxisData.count - 1)
        
        let xAxisData = day.map {
            DateFormatter.customDateFormatter(format: .time(withOnly: .hoursAndMinutes)).string(from: TimeConverter.getDate(from: $0.dt))
        }
        self.xAxisView.configure(data: xAxisData)
    }
    
    func prepareView() {
        self.topStack = UIStackView(arrangedSubviews: [self.yAxisView, self.gridView])
        self.bottomStack = UIStackView(arrangedSubviews: [self.spacer, self.xAxisView])
        self.mainStack = UIStackView(arrangedSubviews: [self.topStack, self.bottomStack])
        self.mainStack.axis = .vertical
        self.topStack.axis = .horizontal
        self.bottomStack.axis = .horizontal
        self.topStack.distribution = .fill
        self.bottomStack.distribution = .fill
        self.addSubview(self.mainStack)
        
        self.mainStack.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        self.spacer.snp.makeConstraints {
            $0.width.equalTo(yAxisView.snp.width)
        }
    }
}

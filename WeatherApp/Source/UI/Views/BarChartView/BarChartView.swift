//
//  BarChartView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 13.10.2023.
//

import UIKit
import SnapKit

class BarChartView: UIScrollView {
    
    // MARK: -
    // MARK: Variables
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    // MARK: -
    // MARK: Init
    
    init() {
        super.init(frame: CGRect())
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // MARK: -
    // MARK: Public
    
    // MARK: -
    // MARK: Public
    
    public func configure(data: [Period]) {
        self.addSubview(self.stackView)
        self.stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        data.forEach {
            let barView = BarView()
            let title = DateFormatter.custom(format: .time(withOnly: [.hours, .minutes]), timeZone: .gmt).string(from: TimeConverter.getDate(from: $0.dt))
            barView.configure(title: title, value: CGFloat($0.clouds.all))
            
            self.stackView.addArrangedSubview(barView)
        }
        
        self.stackView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

//
//  BarView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 13.10.2023.
//

import UIKit
import SnapKit

final class BarView: UIStackView {
    
    // MARK: -
    // MARK: Variables
    
    var titleLabel = UILabel()
    var valueLabel = UILabel()
    var barContainer = UIView()
    var barView = UIView()
    
    var value: CGFloat = 0
    
    func configure(title: String, value: CGFloat) {
        self.titleLabel.textAlignment = .center
        self.valueLabel.textAlignment = .right
        self.titleLabel.font = Fonts.SFProDisplay.regular.font(size: 15)
        self.valueLabel.font = Fonts.SFProDisplay.regular.font(size: 15)
        self.titleLabel.text = title
        self.valueLabel.text = " \(Int(value)) %"
        self.value = value / 100
        self.setupLayout()
    }
    
    func setupLayout() {
        addViews()
    }
    
    func addViews() {
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 8
        self.addArrangedSubview(self.titleLabel)
        self.addArrangedSubview(self.barContainer)
        self.addArrangedSubview(self.valueLabel)
        self.barContainer.addSubview(self.barView)
        
        self.barContainer.backgroundColor = Colors.backgroundGreen.color
        self.barView.backgroundColor = Colors.carrotOrange.color
    }
    
    func addConstraints() {
        self.titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        self.valueLabel.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        self.barView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            let fullWidth = self.frame.size.width - 116
            $0.width.equalTo(self.value * fullWidth)
            
            $0.height.equalTo(self.valueLabel.intrinsicContentSize.height)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addConstraints()
        
        self.barContainer.layer.cornerRadius = self.barContainer.frame.height / 2
        self.barView.layer.cornerRadius = self.barContainer.frame.height / 2
    }
}

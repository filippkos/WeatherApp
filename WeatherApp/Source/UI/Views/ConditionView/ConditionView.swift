//
//  ConditionView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 27.09.2023.
//

import UIKit
import SnapKit

final class ConditionView: UIView {
    
    // MARK: -
    // MARK: Variables
    
    let valueLabel = UILabel()
    let differenceLabel = UILabel()
    var stackView = UIStackView()
    
    // MARK: -
    // MARK: Init
    
    init() {
        super.init(frame: CGRect())
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    // MARK: -
    // MARK: Public
    
    func setup() {
        self.backgroundColor = .clear
        self.setupLabels()
        self.addViews()
        self.addConstraints()
    }
    
    func configure() {
        self.valueLabel.text = "*****"
        self.differenceLabel.text = "*****"
    }
    
    func addViews() {
        self.stackView.axis = .horizontal
        self.stackView.distribution = .fill
        self.valueLabel.textAlignment = .left
        self.differenceLabel.textAlignment = .right
        self.stackView = UIStackView(arrangedSubviews: [self.valueLabel, self.differenceLabel])
        self.addSubview(self.stackView)

    }
    
    func setupLabels() {
        self.valueLabel.font = Fonts.SFProDisplay.regular.font(size: 22)
    }
    
    func addConstraints() {
        self.stackView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
}

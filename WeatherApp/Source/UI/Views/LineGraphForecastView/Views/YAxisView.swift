//
//  YAxisView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 29.08.2023.
//

import UIKit
import SnapKit

final class YAxisView: UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually

        return stack
    }()
    
    func configure(data: [String]) {
        self.addSubview(self.stackView)
        self.stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        data.forEach {
            self.stackView.addArrangedSubview(self.markLabel(text: $0))
        }
        
        self.stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(5)
        }
    }
    
    private func markLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = Fonts.SFProDisplay.regular.font(size: 12)
        label.textColor = Colors.matteGrey.color
        label.textAlignment = .center
        label.text = text
        
        return label
    }
}

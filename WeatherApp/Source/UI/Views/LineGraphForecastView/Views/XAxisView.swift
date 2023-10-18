//
//  XAxisView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 29.08.2023.
//

import UIKit
import SnapKit

final class XAxisView: UIView {
    
    // MARK: -
    // MARK: Variables
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: -
    // MARK: Public
    
    public func configure(data: [String]) {
        self.addSubview(self.stackView)
        self.stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        data.forEach {
            self.stackView.addArrangedSubview(self.markLabel(with: $0))
        }
        
        self.stackView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: -
    // MARK: Private

    private func markLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = Fonts.SFProDisplay.regular.font(size: 12)
        label.textColor = Colors.matteGrey.color
        label.textAlignment = .center
        label.text = text
        
        return label
    }
}

//
//  GridView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 29.08.2023.
//

import UIKit
import SnapKit

final class GridView: UIView {
    
    var data: [Double] = []
    var min: Double = 0
    var max: Double = 0
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    func configure(data: [Double], min: Double, max: Double, num: Int) {
        self.addSubview(self.stackView)
        self.stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        (0...num).forEach { _ in
            self.stackView.addArrangedSubview(self.horizontalGridLine())
        }
        
        self.data = data
        self.min = min
        self.max = max

        
        self.stackView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func horizontalGridLine() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        let line = UIView()
        container.addSubview(line)
        line.backgroundColor = .lightGray
        line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        return container
    }
    
    private func point(frame: CGRect) -> UIView {
        let point = UIView()
        point.frame = frame
        point.backgroundColor = Colors.carrotOrange.color
        
        return point
    }
    
    private func scale() {
        
    }
    
    override func layoutSubviews() {

    }
    
    func quadCurvedPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        var horizontalStep = 0
        if self.data.count != 0 {
            horizontalStep = Int(self.frame.width) / self.data.count - 1
        }
        
        let verticalScaleRange = (self.max - self.min) + 20
        let verticalStep = self.frame.height / verticalScaleRange
        var count = horizontalStep / 2
        
        
        self.data.forEach {
            let yPosition = self.frame.height - ($0 * verticalStep)
            let frame = CGRect(x: count, y: Int(yPosition), width: 5, height: 5)
            self.addSubview(point(frame: frame))
            count += horizontalStep
        }
    }
}


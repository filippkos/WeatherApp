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
    var chartView = UIView()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    func configure(data: [Double], min: Double, max: Double, num: Int) {
        
        self.backgroundColor = .clear
        self.addSubview(self.stackView)
        self.stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        (0...num).forEach { _ in
            self.stackView.addArrangedSubview(self.horizontalGridLine())
        }
        
        self.data = data
        self.min = min - 5
        self.max = max + 5
        self.chartView.frame = self.bounds
        self.chartView.backgroundColor = .clear
        
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
    
    private func drawPoint(point: CGPoint, radius: CGFloat, color: UIColor) {
        let point = UIBezierPath(ovalIn: CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2))
        color.setFill()
        point.fill()
        
        let pointLayer = CAShapeLayer()
        pointLayer.path = point.cgPath
        pointLayer.fillColor = Colors.carrotOrange.color.cgColor
        self.chartView.layer.addSublayer(pointLayer)
    }
    
    private func quadCurvedPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        var horizontalStep: CGFloat = 0
        horizontalStep = CGFloat(Int(self.frame.width) / self.data.count - 1)

        var p1 = CGPoint(x: horizontalStep / 2, y: self.yPositionFor(index: 0))
        path.move(to: p1)

        self.drawPoint(point: p1, radius: 5, color: Colors.carrotOrange.color)
        
        if (self.data.count == 2) {
            path.addLine(to: CGPoint(x: horizontalStep, y: self.yPositionFor(index: 1)))
            return path
        }
        
        var oldControlPoint: CGPoint?
        
        for i in 1..<self.data.count {

            let p2 = CGPoint(x: horizontalStep * CGFloat(i) + (horizontalStep / 2), y: self.yPositionFor(index: i))
            self.drawPoint(point: p2, radius: 5, color: Colors.carrotOrange.color)
            
            var p3: CGPoint?
            
            if i < self.data.count - 1 {
                p3 = CGPoint(x: horizontalStep * CGFloat(i + 1) + (horizontalStep / 2), y: self.yPositionFor(index: i + 1))
            }
            
            let newControlPoint = self.controlPointForPoints(p1: p1, p2: p2, next: p3)
            
            path.addCurve(to: p2, controlPoint1: oldControlPoint ?? p1, controlPoint2: newControlPoint ?? p2)
            
            p1 = p2
            oldControlPoint = self.oppositePointFor(point: newControlPoint, center: p2)
        }
        
        return path
    }
    
    private func controlPointForPoints(p1: CGPoint, p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }

        let leftMidPoint  = midPointFor(p1: p1, p2: p2)
        let rightMidPoint = midPointFor(p1: p2, p2: p3)

        var controlPoint = midPointFor(p1: leftMidPoint, p2: oppositePointFor(point: rightMidPoint, center: p2)!)

        if p1.y.isBetween(a: p2.y, b: controlPoint.y) {
            controlPoint.y = p1.y
        } else if p2.y.isBetween(a: p1.y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }

        let accessorialControlPoint = oppositePointFor(point: controlPoint, center: p2)!
        if p2.y.isBetween(a: p3.y, b: accessorialControlPoint.y) {
            controlPoint.y = p2.y
        }
        if p3.y.isBetween(a: p2.y, b: accessorialControlPoint.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }

        // make lines easier
        controlPoint.x += (p2.x - p1.x) * 0.1

        return controlPoint
    }
    
    private func oppositePointFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let point = point, let center = center else {
            return nil
        }
        
        let oppositeX = 2 * center.x - point.x
        let yDifference = abs(point.y - center.y)
        let oppositeY = center.y + yDifference * (point.y < center.y ? 1 : -1)
        
        return CGPoint(x: oppositeX, y: oppositeY)
    }
    
    private func midPointFor(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }
    
    private func yPositionFor(index: Int) -> CGFloat {
        let verticalScaleRange = self.verticalRange()

        let verticalStep = self.frame.height / verticalScaleRange

        return CGFloat(self.bounds.height + (self.differenceFromZero() * verticalStep) - (self.data[index] * verticalStep))
    }
    
    private func differenceFromZero() -> Double {
        
        return self.min >= -5 ? self.min : -abs(self.min)
    }
    
    private func verticalRange() -> Double {
        var temp = self.max
        var counter = 0
        while temp > self.min {
            temp -= 10
            counter += 1
        }
        
        return Double(counter * 10)
    }
    
    override func draw(_ rect: CGRect) {
        guard self.data.count != 0 else {
            return
        }
        let path = self.quadCurvedPath()

        UIColor.black.setStroke()
        path.lineWidth = 3
        path.stroke()
        
        let chartLayer = CAShapeLayer()
        chartLayer.path = path.cgPath
        chartLayer.strokeColor = UIColor.black.cgColor
        chartLayer.fillColor = UIColor.clear.cgColor
        
        self.chartView.layer.insertSublayer(chartLayer, at: 0)
        self.addSubview(self.chartView)
    }
}


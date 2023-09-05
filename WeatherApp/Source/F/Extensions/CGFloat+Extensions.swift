//
//  CGFloat+Extensions.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 02.09.2023.
//

import Foundation

extension CGFloat {
    func isBetween(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}

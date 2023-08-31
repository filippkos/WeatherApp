//
//  TemperatureConverter.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 27.07.2023.
//

import Foundation

public final class TemperatureConverter {
    
    public static func roundedCelsius(from kelvin: Double) -> Int {
        return Int(kelvin - 273)
    }
    
    public static func roundedDoubleCelsius(from kelvin: Double) -> Double {
        return kelvin - 273
    }
    
    public static func stringCelsius(from kelvin: Double) -> String {
        return "\(Int(kelvin - 273))°"
    }
}

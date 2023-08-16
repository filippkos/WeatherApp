//
//  CityListModel.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 14.08.2023.
//

import Foundation

// MARK: - SingleCity
struct SingleCity: Codable {
    let id: Int
    let name, state, country: String
    let coord: Coordinates
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lon, lat: Double
}

typealias CityList = [SingleCity]

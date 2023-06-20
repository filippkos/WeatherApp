//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 19.06.2023.
//

import UIKit

class Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    let navigationController: UINavigationController
    
    // MARK: -
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.prepareForecastViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareForecastViewController() {
        let controller = ForecastViewController()
        
        self.navigationController.setViewControllers([controller], animated: true)
    }
    
}

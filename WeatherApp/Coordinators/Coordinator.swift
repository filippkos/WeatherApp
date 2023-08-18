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
        self.prepareContainerViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareContainerViewController() {
        let containerController = ContainerViewController()
        let detailsController = DetailsViewController(type: .details)
        let forecastController = ForecastViewController(type: .forecast)
        
        containerController.add(detailsController)
        containerController.add(forecastController)
        
        self.navigationController.setViewControllers([containerController], animated: true)
    }
}

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
        self.navigationController.navigationBar.isHidden = true
        self.prepareContainerViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareContainerViewController() {
        let containerController = ContainerViewController()
        let detailsController = DetailsViewController(type: .details, parent: containerController)
        let forecastController = ForecastViewController(type: .forecast, parent: containerController)
        
        containerController.add(detailsController)
        containerController.add(forecastController)
       
        self.navigationController.setViewControllers([containerController], animated: true)
    }
}

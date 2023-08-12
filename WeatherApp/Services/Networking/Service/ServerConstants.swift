//
//  ServerConstants.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 21.06.2023.
//

import Foundation

protocol BaseComponents {
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
}

enum ServerConstants {
    
    struct ForecastURLComponents: BaseComponents {
        
        let scheme = "https"
        let host = "api.openweathermap.org"
        let path = "/data/2.5/forecast"
    }

    struct ImageURLComponents: BaseComponents {
        
       let scheme = "https"
       let host = "openweathermap.org"
       let path = "/img/wn/"
    }
    
    case forecast
    case image
    
    var type: URLComponents {
        switch self {
            
        case .forecast:
            return self.createComponents(type: ForecastURLComponents())
        case .image:
            return self.createComponents(type: ImageURLComponents())
        }
    }
    
    func createComponents(type: BaseComponents) -> URLComponents {
        var mainComponents = URLComponents()
        
        mainComponents.scheme = type.scheme
        mainComponents.host = type.host
        mainComponents.path = type.path
        
        return mainComponents
    }
}
    


//
//  NetworkRequestModel.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 21.06.2023.
//

import Foundation

public enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct NetworkRequestModel {
    
    var requestType: ServerConstants
    var params: [String : String]?
    var endPoint: String?
    var httpMethod: HttpMethod
    var request: URLRequest {
        let urlComponents = self.createUrlComponents(requestType: requestType, params: params, endPoint: endPoint)
        var request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = (HttpMethod.get).rawValue
        
        return request
    }
    
    private func createUrlComponents(requestType: ServerConstants, params: [String : String]?, endPoint: String?) -> URLComponents {
        var components = URLComponents()
        components = requestType.type
        
        if let params = params {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        if let endPoint = endPoint {
            components.path += endPoint
        }
        
        return components
    }
}

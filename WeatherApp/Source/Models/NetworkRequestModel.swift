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
    
    var query: String
    var params: [String : String]?
    var httpMethod: HttpMethod
    var request: URLRequest {
        let urlComponents = self.createUrlComponents(query: query, params: params)
        var request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = (HttpMethod.get).rawValue
        
        return request
    }
    
    private func createUrlComponents(query: String, params: [String : String]?) -> URLComponents {
        var components = URLComponents()
            components.scheme = ServerConstants.scheme
            components.host = ServerConstants.host
            components.path = ServerConstants.path + ServerConstants.version + query
        if let params = params {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        return components
    }
}

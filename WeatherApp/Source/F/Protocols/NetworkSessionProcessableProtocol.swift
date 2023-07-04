//
//  NetworkSessionProcessableProtocol.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 21.06.2023.
//

import Foundation

protocol NetworkSessionProcessable {
    
    static func task<Model: Codable>(requestModel: NetworkRequestModel, completion: @escaping F.ResultHandler<Model>) -> URLSessionDataTask
}

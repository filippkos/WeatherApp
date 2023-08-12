//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 21.06.2023.
//

import Foundation

class NetworkManager: NetworkSessionProcessable {
    
    @discardableResult
    static func task<Model>(requestModel: NetworkRequestModel, completion: @escaping F.ResultHandler<Model>) -> URLSessionDataTask  where Model : Decodable, Model : Encodable {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: requestModel.request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            let code = (response as? HTTPURLResponse)?.statusCode
            if code != 200 {
                completion(.failure(code?.description as! Error))
            } else {
                if let data = data {
                    completion(self.decode(data: data))
                } else {
                    completion(.failure("no data" as! Error))
                }
            }
        }
        
        task.resume()

        return task
    }
    
    @discardableResult
    static func image(requestModel: NetworkRequestModel, completion: @escaping F.ResultHandler<Data>) -> URLSessionDataTask {
        let url = requestModel.request.url ?? URL(fileURLWithPath: "")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                debugPrint("Error downloading data: \(e)")
                completion(.failure(e))
            } else {
                if let res = response as? HTTPURLResponse {
                    debugPrint("Downloaded data with response code \(res.statusCode)")
                    if let data = data {
                            completion(.success(data))
                    } else {
                        if let error = error {
                            completion(.failure(error))
                        }
                    }
                } else {
                    if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
    
    
    static func decode<Model: Codable>(data: Data) -> Result<Model, Error> {
        let decoder = JSONDecoder()
        do {
            return .success(try decoder.decode(Model.self, from: data))
        } catch {
            debugPrint("***Parser log - \(error)")
            
            return .failure(error)
        }
    }
}

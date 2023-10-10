//
//  ForecastModelStorage.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 24.08.2023.
//

import Foundation
import RxSwift
import RxCocoa

enum ForecastModelStorageEvents {
    case needUpdate
}

class ForecastModelStorage {
    
    // MARK: -
    // MARK: Variables
    
    var city: String = ""
    var id: String = ""
    var list: BehaviorRelay<[Period]> = BehaviorRelay(value: [])
    var days: [[Period]] = []
    var currentDay: [Period] = []
    var selectedDay: BehaviorRelay<[Period]> = BehaviorRelay(value: [])
    
    // MARK: -
    // MARK: Public
    
    func forecast(cityID: String, completion: @escaping F.VoidFunc<ForecastModel>) {
        NetworkManager.task(requestModel: self.prepareRequestModel(id: cityID)) { [weak self] (result: Result<ForecastModel, Error>) in
            switch result {
            case .success(let model):
                self?.list.accept(model.list)
                self?.days = self?.list.value.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount() ?? 0) ?? []
                self?.currentDay = self?.days.first ?? []
                self?.city = model.city.name
                completion(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectedDate() -> String {
        return TimeConverter.getStringDate(from: self.selectedDay.value.first?.dt ?? 0)
    }
    
    func currentDate() -> String {
        return TimeConverter.getStringDate(from: Int(Date().timeIntervalSince1970))
    }
    
    func tomorrowDate() -> String {
        let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return TimeConverter.getStringDate(from: Int(date?.timeIntervalSince1970 ?? 0))
    }
    
    private func prepareRequestModel(id: String) -> NetworkRequestModel {
        let params = ["id" : id, "appid" : "83b161664a26ce94b708c5723c38496c"]
        
        return NetworkRequestModel(requestType: .forecast, params: params, httpMethod: .get)
    }
    
    private func getTodayPeriodsCount() -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.list.value.first?.dt ?? 0))
        let hours = DateFormatter.custom(format: .time(withOnly: .hours)).string(from: date as Date)
        
        return (24 - (Int(hours) ?? 0)) / 3
    }
}

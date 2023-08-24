//
//  ContainerViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ContainerViewController: BaseParentController, RootViewGettable, UITextFieldDelegate {
        
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = ContainerView
    
    // MARK: -
    // MARK: Variables
    
    private let dispose = DisposeBag()
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView?.textFieldView.textField.delegate = self
        self.forecast(cityID: "456172")
        self.bind()
    }
    
    func showChildController(_ type: ChildControllerType) {
        self.rootView?.contentView.subviews.forEach({ $0.removeFromSuperview() })
        self.childControllers.forEach {
            if $0.type == type {
                self.rootView?.contentView.addSubview($0.view)
            }
        }
    }

    // MARK: -
    // MARK: Private
    
    private func bind() {
        
        self.rootView?.textFieldView.actionButton
            .rx
            .tap
            .bind { [weak self] in
                let requestText = self?.rootView?.textFieldView.textField.text
                if  requestText != "" {
                    let id = self?.getCityID(cityName: requestText ?? "") ?? ""
                    if id != "" {
                        self?.city = self?.rootView?.textFieldView.textField.text ?? ""
                        self?.forecast(cityID: id)
                    } else {
                        print("wrong city name")
                    }
                } else {
                    print("empty search text")
                }
                self?.rootView?.textFieldView.textField.placeholder = self?.city
                self?.rootView?.textFieldView.textField.text = ""
                self?.rootView?.textFieldView.textField.endEditing(true)
            }
            .disposed(by: self.dispose)
        
        self.rootView?.todayButton
            .rx
            .tap
            .bind { [weak self] in
                self?.selectedDay.accept(self?.days[0] ?? [])
                self?.showChildController(.details)
            }
        self.rootView?.tomorrowButton
            .rx
            .tap
            .bind { [weak self] in
                self?.selectedDay.accept(self?.days[1] ?? [])
                self?.showChildController(.details)
            }
        self.rootView?.forecastButton
            .rx
            .tap
            .bind { [weak self] in
                self?.showChildController(.forecast)
            }
    }
    
    func prepareRequestModel(id: String) -> NetworkRequestModel {
        let params = ["id" : id, "appid" : "83b161664a26ce94b708c5723c38496c"]
        
        return NetworkRequestModel(requestType: .forecast, params: params, httpMethod: .get)
    }
    
    func forecast(cityID: String) {
        NetworkManager.task(requestModel: self.prepareRequestModel(id: cityID)) { [weak self] (result: Result<ForecastModel, Error>) in
            switch result {
            case .success(let model):
                self?.list = model.list
                self?.days = self?.list.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount() ?? 0) ?? []
                self?.currentDay = self?.days.first ?? []
                self?.city = model.city.name
                
                self?.childControllers.forEach {
                    $0.list.accept(self?.list ?? [])
                }
                
                DispatchQueue.main.async {
                    self?.rootView?.configureDefault(cityName: model.city.name, selectedDay: self?.currentDay ?? [])
                    self?.childControllers.forEach {
                        ($0.view as! BaseChildView).collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCityID(cityName: String) -> String {
        var result = ""
        
        cityList()?.forEach {
            if $0.name.lowercased() == cityName.lowercased() {
                result = $0.id.description
            }
        }
        
        return result
    }
    
    func cityList() -> CityList? {
        guard let path = Bundle.main.url(forResource: "CityList", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(CityList.self, from: data)
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getTodayPeriodsCount() -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.list.first?.dt ?? 0))
        let hours = DateFormatter.customDateFormatter(format: .time(withOnly: .hours)).string(from: date as Date)
        
        return (24 - (Int(hours) ?? 0)) / 3
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.rootView?.textFieldView.textField.placeholder = ""
    }
}


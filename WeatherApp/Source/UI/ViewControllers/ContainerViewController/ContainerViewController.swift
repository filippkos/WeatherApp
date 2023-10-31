//
//  ContainerViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ContainerViewController: BaseParentController, RootViewGettable, UITextFieldDelegate {
        
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
        self.storage.forecast(cityID: "3874930") { model in
            
            DispatchQueue.main.async {
                self.rootView?.configureDefault(cityName: model.city.name, selectedDay: self.storage.currentDay)
                self.castedChildren.forEach {
                    ($0.view as! BaseChildView).collectionView.reloadData()
                }
            }
        }
        self.bind()
        self.updateButtonsState()
    }
    
    override func showChildController(_ type: ChildControllerType) {
        self.rootView?.contentView.subviews.forEach({ $0.removeFromSuperview() })
        self.castedChildren.forEach {
            if $0.type == type {
                self.rootView?.contentView.addSubview($0.view)
            }
        }
    }

    // MARK: -
    // MARK: Private
    
    override func updateButtonsState() {
        super.updateButtonsState()

        self.rootView?.buttons.forEach {
            $0.backgroundColor = .white
        }
        
        var calendar = Calendar.current
        
        guard let view = self.rootView?.contentView.subviews.first else {
            return
        }
        
        if type(of: view) === DetailsView.self {
            if calendar.isDateInToday(self.storage.selectedDate()) {
                self.rootView?.todayButton.backgroundColor = Colors.cellBackgroundGreen.color
            } else if calendar.isDateInTomorrow(self.storage.selectedDate()) {
                self.rootView?.tomorrowButton.backgroundColor = Colors.cellBackgroundGreen.color
            } else {
                return
            }
        } else {
            self.rootView?.forecastButton.backgroundColor = Colors.cellBackgroundGreen.color
        }
    }
    
    private func bind() {
        
        self.rootView?.textFieldView.actionButton
            .rx
            .tap
            .bind { [weak self] in
                let requestText = self?.rootView?.textFieldView.textField.text
                if  requestText != "" {
                    let id = self?.getCityID(cityName: requestText ?? "") ?? ""
                    if id != "" {
                        self?.storage.city = self?.rootView?.textFieldView.textField.text ?? ""
                        self?.storage.forecast(cityID: id) { model in
                            DispatchQueue.main.async {
                                self?.rootView?.configureDefault(cityName: model.city.name, selectedDay: self?.storage.currentDay ?? [])
                                self?.castedChildren.forEach {
                                    ($0.view as! BaseChildView).collectionView.reloadData()
                                }
                            }
                        }
                    } else {
                        print("wrong city name")
                    }
                } else {
                    print("empty search text")
                }
                self?.rootView?.textFieldView.textField.placeholder = self?.storage.city
                self?.rootView?.textFieldView.textField.text = ""
                self?.rootView?.textFieldView.textField.endEditing(true)
            }
            .disposed(by: self.dispose)
        
        self.rootView?.todayButton
            .rx
            .tap
            .bind { [weak self] in
                self?.storage.selectedDay.accept(self?.storage.days.first ?? [] )
                self?.showChildController(.details)
                self?.updateButtonsState()
            }
            .disposed(by: self.dispose)
        
        self.rootView?.tomorrowButton
            .rx
            .tap
            .bind { [weak self] in
                self?.storage.selectedDay.accept(self?.storage.days.dropFirst().first ?? [])
                self?.showChildController(.details)
                self?.updateButtonsState()
            }
            .disposed(by: self.dispose)
        
        self.rootView?.forecastButton
            .rx
            .tap
            .bind { [weak self] in
                self?.showChildController(.forecast)
                self?.updateButtonsState()
            }
            .disposed(by: self.dispose)
    }

    func prepareRequestModel(id: String) -> NetworkRequestModel {
        let params = ["id" : id, "appid" : "83b161664a26ce94b708c5723c38496c"]
        
        return NetworkRequestModel(requestType: .forecast, params: params, httpMethod: .get)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.rootView?.textFieldView.textField.placeholder = ""
    }
}


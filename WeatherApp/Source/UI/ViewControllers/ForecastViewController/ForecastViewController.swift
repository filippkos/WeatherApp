//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, RootViewGettable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = ForecastView
    
    // MARK: -
    // MARK: Variables
    
    var city: String = ""
    var id: String = ""
    var list: [Period] = []
    var days: [[Period]] = []
    var selectedDay: [Period] = []
    private let dispose = DisposeBag()
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView.dataSource = self
        self.rootView?.collectionView.delegate = self
        self.rootView?.collectionView.registerDefaultCell(cellClass: ForecastCollectionViewCell.self)
        self.navigationController?.navigationBar.isHidden = true
        self.rootView?.flowLayoutListConfigure()
        self.forecast(cityID: "456172")
        self.bind()
    }

    // MARK: -
    // MARK: Private
    
    private func bind() {
        self.rootView?.textFieldView.textField
            .rx
            .text
            .bind { [weak self] text in
                self?.city = text ?? ""
            }
            .disposed(by: self.dispose)
        
        self.rootView?.textFieldView.actionButton
            .rx
            .tap
            .bind { [weak self] in
                self?.forecast(cityID: self?.getCityID(cityName: self?.city ?? "") ?? "")
                self?.rootView?.textFieldView.textField.placeholder = self?.city
                self?.rootView?.textFieldView.textField.text = ""
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
    
    func forecast(cityID: String) {
        NetworkManager.task(requestModel: self.prepareRequestModel(id: cityID)) { [weak self] (result: Result<ForecastModel, Error>) in
            switch result {
            case .success(let model):
                self?.list = model.list
                self?.days = self?.list.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount() ?? 0) ?? []
                self?.selectedDay = self?.days.first ?? []
                self?.city = model.city.name
                
                DispatchQueue.main.async {
                    self?.rootView?.configureDefault(cityName: model.city.name, selectedDay: self?.selectedDay ?? [])
                    self?.rootView?.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTodayPeriodsCount() -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.list.first?.dt ?? 0))
        let hours = DateFormatter.customDateFormatter(format: .time(withOnly: .hours)).string(from: date as Date)
        
        return (24 - (Int(hours) ?? 0)) / 3
    }
    
    // MARK: -
    // MARK: UITableView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ForecastCollectionViewCell
        cell = self.rootView?.collectionView.dequeueReusableCell(cellClass: ForecastCollectionViewCell.self, indexPath: indexPath) ?? ForecastCollectionViewCell()
        cell.configure(day: self.days[indexPath.row])
        return cell
    }
}

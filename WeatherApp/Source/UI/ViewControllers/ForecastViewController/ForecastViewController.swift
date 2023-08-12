//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.06.2023.
//

import UIKit

class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewGettable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = ForecastView
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.tableView.dataSource = self
        self.rootView?.tableView.delegate = self
        self.rootView?.tableView.register(cellClass: ForecastTableViewCell.self)
        self.rootView?.tableView.register(headerFooterClass: ForecastTableViewHeaderFooterView.self)
        
        self.forecast()
    }
    
    // MARK: -
    // MARK: Variables
    
    var city: String = ""
    var list: [Period] = []
    var days: [[Period]] = []
    var selectedDay: [Period] = []
    
    // MARK: -
    // MARK: Private
    
    func prepareRequestModel(id: String) -> NetworkRequestModel {
        let params = ["id" : id, "appid" : "83b161664a26ce94b708c5723c38496c"]
        
        return NetworkRequestModel(requestType: .forecast, params: params, httpMethod: .get)
    }
    
    func forecast() {
        NetworkManager.task(requestModel: self.prepareRequestModel(id: "456172")) { [weak self] (result: Result<ForecastModel, Error>) in
            switch result {
            case .success(let model):
                self?.list = model.list
                self?.days = self?.list.splitArray(step: 8, firstStep: self?.getTodayPeriodsCount() ?? 0) ?? []
                self?.selectedDay = self?.days.first ?? []
                self?.city = model.city.name
                
                DispatchQueue.main.async {
                    self?.rootView?.configureDefault(cityName: model.city.name, selectedDay: self?.selectedDay ?? [])
                    self?.rootView?.tableView?.reloadData()
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TimeConverter.getStringDate(from: self.days[section].first?.dt ?? 0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.rootView?.tableView.dequeueReusableHeaderFooterView(withHeaderFooterClass: ForecastTableViewHeaderFooterView.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.days[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCellClass: ForecastTableViewCell.self, for: indexPath)
        cell.configure(model: self.days[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.rootView?.changeLabels()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDay = self.days[indexPath.section]
        DispatchQueue.main.async {
            self.rootView?.configureDefault(cityName: self.city, selectedDay: self.selectedDay)
            self.rootView?.tableView?.reloadData()
        }
    }
}

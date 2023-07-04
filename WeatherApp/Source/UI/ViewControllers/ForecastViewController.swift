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
        self.forecast()
    }
    
    // MARK: -
    // MARK: Variables
    
    var city: String = ""
    var lists: [[List]] = []
    
    // MARK: -
    // MARK: Private
    
    func prepareRequestModel(id: String) -> NetworkRequestModel {
        let query = "forecast"
        let params = ["id" : id, "appid" : "83b161664a26ce94b708c5723c38496c"]
        
        return NetworkRequestModel(query: query, params: params, httpMethod: .get)
    }
    
    func forecast() {
        NetworkManager.task(requestModel: self.prepareRequestModel(id: "456172")) { [weak self] (result: Result<ForecastModel, Error>) in
            switch result {
            case .success(let model):
                self?.lists = model.grouped
                self?.city = model.city.name
                DispatchQueue.main.async {
                    
                    self?.rootView?.configure(city: self?.city ?? "")
                    self?.rootView?.tableView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: -
    // MARK: UITableView DataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.lists[section].first?.dt ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date as Date)
        
        return localDate
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.lists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lists.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: ForecastTableViewCell.self)
        cell.configure(model: self.lists[indexPath.section][indexPath.row])
        
        return cell
    }
}

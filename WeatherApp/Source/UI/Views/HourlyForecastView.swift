//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 24.07.2023.
//

import UIKit

class HourlyForecastView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var arrayOfViews: [UIView] = []
    var model: [Period] = []
    let layout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: CGRect(), collectionViewLayout: layout)
        
        self.registerDefaultCell(cellClass: HourlyForecastViewCell.self)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.register(cellClass: HourlyForecastViewCell.self)
        self.dataSource = self
        self.delegate = self
        self.prepareLayout()
        self.collectionViewLayout = self.layout
    }
    
    func setup(for day: [Period]) {
        self.model = day
        
        self.reloadData() 
    }
    
    private func prepareLayout() {
        self.layout.scrollDirection = .horizontal
        self.layout.sectionInset = self.getInsets()
        self.layout.itemSize = CGSize(width: 70, height: 146)
        self.layout.minimumLineSpacing = 5
        self.isScrollEnabled = true
    }
    
    private func getInsets() -> UIEdgeInsets {
        let totalCellWidth = self.bounds.width
        
        let horizontalInset = (self.bounds.width - CGFloat(totalCellWidth)) / 2
        let verticalInset = (self.bounds.size.height - CGFloat(100)) / 2

        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    func downloadWeatherImage(period: Period) -> UIImage? {
        let icon = period.weather[0].icon
        var endPoint = icon + "@2x.png"
        
        let requestModel = NetworkRequestModel(requestType: .image, endPoint: endPoint, httpMethod: .get)
        
        var defaultImage: UIImage?
        NetworkManager.image(requestModel: requestModel) { [weak self] (result: Result<Data, Error>) in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    defaultImage = image
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return defaultImage
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellClass: HourlyForecastViewCell.self, indexPath: indexPath)
        
        let icon = self.model[indexPath.row].weather[0].icon
        var endPoint = icon + "@2x.png"
        
        let requestModel = NetworkRequestModel(requestType: .image, endPoint: endPoint, httpMethod: .get)
        
        NetworkManager.image(requestModel: requestModel) { [weak self] (result: Result<Data, Error>) in
            switch result {
                
            case .success(let data):
                if let self, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.configure(period: self.model[indexPath.row], image: image)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }

        return cell
    }
}

//
//  BaseParentController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 20.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class BaseParentController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    var storage: ForecastModelStorage
    var castedChildren: [BaseChildController] {
        return self.children as! [BaseChildController]
    }
    
    // MARK: -
    // MARK: Init
    
    init(storage: ForecastModelStorage) {
        self.storage = storage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public
    
    func updateButtonsState() {
        
    }
    
    func showChildController(_ type: ChildControllerType) {
        
    }
}

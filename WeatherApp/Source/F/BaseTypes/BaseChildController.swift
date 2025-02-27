//
//  BaseChildController.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

enum ChildControllerType {
    
    case details
    case forecast
}

class BaseChildController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    var storage: ForecastModelStorage
    var castedParent: BaseParentController {
        return self.parent as! BaseParentController
    }
    
    let type: ChildControllerType

    
    // MARK: -
    // MARK: Init
    
    init(storage: ForecastModelStorage, type: ChildControllerType) {
        self.storage = storage
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

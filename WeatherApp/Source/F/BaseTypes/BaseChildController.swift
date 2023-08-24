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
    
    let type: ChildControllerType
    var list: BehaviorRelay<[Period]> = BehaviorRelay(value: [])
    var parentController: ContainerViewController?
    
    // MARK: -
    // MARK: Init
    
    init(type: ChildControllerType, parent: ContainerViewController) {
        self.type = type
        self.parentController = parent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

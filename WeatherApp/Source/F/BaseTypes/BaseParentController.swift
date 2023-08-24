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
    
    var city: String = ""
    var id: String = ""
    var list: [Period] = []
    var days: [[Period]] = []
    var currentDay: [Period] = []
    var selectedDay: BehaviorRelay<[Period]> = BehaviorRelay(value: [])
    var childControllers: [BaseChildController] = []
}

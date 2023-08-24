//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 17.08.2023.
//

import UIKit

extension ContainerViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        child.view.frame.size = self.rootView?.contentView.frame.size ?? CGSize()
        
        
        if let baseChild = child as? BaseChildController {
            self.childControllers.append(baseChild)
         //   baseChild.parentController = self
        }
        rootView?.contentView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

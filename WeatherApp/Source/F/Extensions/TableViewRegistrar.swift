//
//  TableViewRegistrar.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 12.07.2023.
//

import UIKit

func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

extension UITableView {
    
    @discardableResult
    public func dequeueReusableCell<Result>(withCellClass cellClass: Result.Type, for indexPath: IndexPath) -> Result
        where Result: UITableViewCell
    {
        let cell = self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
        
        guard let value = cell as? Result else {
            fatalError("Can't find identifier")
        }
        
        return value
    }
    
    @discardableResult
    public func dequeueReusableHeaderFooterView<Result>(withHeaderFooterClass headerFooterClass: Result.Type) -> Result
        where Result: UITableViewHeaderFooterView
    {
        let cell = self.dequeueReusableHeaderFooterView(withIdentifier: toString(headerFooterClass))
        
        guard let value = cell as? Result else {
            fatalError("Can't find identifier")
        }
        
        return value
    }
    
    func register(cells: Set<String>, cls: Array<AnyClass>) {
        zip(cells, cls).forEach { type in
            self.register(cell: type.0, cls: type.1)
        }
    }
    
    public func register(cells: UITableViewCell.Type...) {
        let array = cells.map { toString($0) }
        self.register(cells: Set(array), cls: cells.map { $0 })
    }
    
    public func register(cellClass: UITableViewCell.Type) {
        self.register(cell: toString(cellClass), cls: cellClass)
    }
    
    func register(cell: String, cls: AnyClass) {
        let bundle = Bundle(for: cls)
        
        let nib = UINib.init(nibName: cell, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: cell)
    }
    
    public func register(headerFooters: [AnyClass]) {
        headerFooters.forEach { type in
            self.register(headerFooterClass: type)
        }
    }
    
    public func register(headerFooterClass: AnyClass) {
        self.register(headerFooterClass.self, forHeaderFooterViewReuseIdentifier: toString(headerFooterClass))
    }
    
    func register(_ cellClass: AnyClass) {
        let nib = UINib(nibName: toString(cellClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: toString(cellClass))
    }
}

extension UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

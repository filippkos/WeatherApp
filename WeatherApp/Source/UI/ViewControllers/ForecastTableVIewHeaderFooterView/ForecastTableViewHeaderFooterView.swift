//
//  ForecastTableViewHeaderFooterView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 11.07.2023.
//

import UIKit

class ForecastTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = .lightGray
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

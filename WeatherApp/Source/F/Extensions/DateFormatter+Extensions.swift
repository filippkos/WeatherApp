//
//  DateFormatter+Extensions.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 26.07.2023.
//

import Foundation

public extension DateFormatter {
    
    /// 24
    static let hoursFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH"
        
        return timeFormatter
    }()
    
    /// 19:00
    static let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        return timeFormatter
    }()
    
    /// 26 Jun 2023
    static let dateAndTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
       // dateFormatter.timeZone = .current
        
        return dateFormatter
    }()
}

//
//  TimeConverter.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 27.07.2023.
//

import Foundation

public final class TimeConverter {
    
    public static func getDate(from timeStamp: Int) -> Date {
        return NSDate(timeIntervalSince1970: TimeInterval(timeStamp)) as Date
    }

    /// 26 Jun 2023
    public static func getStringDate(from timeStamp: Int) -> String {
        return DateFormatter.custom(format: .date(withOnly: [.day, .wideMonth, .wideYear]), timeZone: .gmt).string(from: NSDate(timeIntervalSince1970: TimeInterval(timeStamp)) as Date)
    }
    
    /// 00:00
    public static func getStringTime(from timeStamp: Int) -> String {
        return DateFormatter.custom(format: .time(withOnly: [.hours, .minutes]), timeZone: .gmt).string(from: NSDate(timeIntervalSince1970: TimeInterval(timeStamp)) as Date)
    }
}

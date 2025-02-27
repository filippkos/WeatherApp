//
//  DateFormatter+Extensions.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 26.07.2023.
//

import Foundation

public extension DateFormatter {
    
    enum DateFormat {
        case time(withOnly: TimeUnits)
        case fullTime(format: FullTimeFormat)
        case date(withOnly: DateUnits)
        case fullDate(format: DateType)
        case dayOfWeek(format: DayOfWeekType)
        case fullTimeAndDate
        
        var format: String {
            switch self {
            case .time(withOnly: let withOnly):
                return withOnly.description
            case .fullTime(format: let format):
                switch format {
                case .twelve:
                    return "hh:mm:ss"
                case .twentyFour:
                    return "HH:mm:ss"
                case .withAMPM:
                    return "hh:mm:ss a"
                }
            case .date(withOnly: let withOnly):
                return withOnly.description
            case .fullDate(format: let format):
                switch format {
                case .numDate(separator: let separator):
                    return "dd\(separator)MM\(separator)yyyy"
                }
            case .dayOfWeek(format: let format):
                switch format {
                case .number:
                    return "e"
                case .letter:
                    return "EEEEE"
                case .abbreviation:
                    return "EEE"
                case .word:
                    return "EEEE"
                }
            case .fullTimeAndDate:
                return "dd MMMM yyyy HH:mm:ss"
            }
        }
    }
    
    struct TimeUnits: OptionSet {
        public let rawValue: Int8
        
        static let hours = TimeUnits(rawValue: 1)
        static let minutes = TimeUnits(rawValue: 1 << 1)
        static let seconds = TimeUnits(rawValue: 1 << 2)

        public init(rawValue: Int8) {
            self.rawValue = rawValue
        }
        
        var description: String {
            var units = [String]()
            if self.contains(.hours) {
                units.append("HH")
            }
            if self.contains(.minutes) {
                units.append("mm")
            }
            if self.contains(.seconds) {
                units.append("ss")
            }

            return units.joined(separator: ":")
        }
    }
    
    struct DateUnits: OptionSet {
        public let rawValue: Int8
        
        static let day = DateUnits(rawValue: 1)
        static let singleNumMonth = DateUnits(rawValue: 1 << 2)
        static let doubleNumMonth = DateUnits(rawValue: 1 << 3)
        static let shortMonth = DateUnits(rawValue: 1 << 4)
        static let wideMonth = DateUnits(rawValue: 1 << 5)
        static let shortYear = DateUnits(rawValue: 1 << 6)
        static let wideYear = DateUnits(rawValue: 1 << 7)

        public init(rawValue: Int8) {
            self.rawValue = rawValue
        }
        
        var description: String {
            var units = [String]()
            if self.contains(.day) {
                units.append("dd")
            }
            if self.contains(.singleNumMonth) {
                units.append("M")
            }
            if self.contains(.doubleNumMonth) {
                units.append("MM")
            }
            if self.contains(.shortMonth) {
                units.append("MMM")
            }
            if self.contains(.wideMonth) {
                units.append("MMMM")
            }
            if self.contains(.shortYear) {
                units.append("yy")
            }
            if self.contains(.wideYear) {
                units.append("yyyy")
            }

            return units.joined(separator: " ")
        }
    }
    
    enum FullTimeFormat {
        case twelve
        case twentyFour
        case withAMPM
    }
    
    enum DateType {
        case numDate(separator: String)
    }
    
    enum DayOfWeekType {
        case number
        case letter
        case abbreviation
        case word
    }
    
    static func custom(
        format: DateFormat? = .fullTimeAndDate,
        locale: Locale? = .current,
        timeZone: TimeZone? = .current
    )
        -> DateFormatter
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format?.format
        
        return dateFormatter
    }
}

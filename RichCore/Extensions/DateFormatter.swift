//
//  DateFormatter.swift
//  
//
//  Created by L God on 2023/1/4.
//

import Foundation

protocol FormatterCalculator {
    func dateString() -> String
}

class Formatter {
    let dateFormatter = DateFormatter()
    
    let durationFormatter = DateComponentsFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        durationFormatter.unitsStyle = .positional
        durationFormatter.zeroFormattingBehavior = [.pad]
        durationFormatter.allowedUnits = [.hour, .minute, .second]
    }
}

class MonthDateFormatter: FormatterCalculator {
    let dateFormatter = DateFormatter()
    
    let durationFormatter = DateComponentsFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM"
    }
    
    func dateString() -> String {
        dateFormatter.string(from: Date())
    }
}


class DayDateFormatter: FormatterCalculator {
    let dateFormatter = DateFormatter()
    
    let durationFormatter = DateComponentsFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func dateString() -> String {
        dateFormatter.string(from: Date())
    }
    
    
}

extension Date {
    static func leftDay(inThisMonth date: Date = Date()) -> Int {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day] , from: date)
        var year = dateComponents.year!
        var month = dateComponents.month!
        
        if month == 12 {
            year+=1
            month = 1
        } else {
            month += 1
        }
        let endDate = DayDateFormatter().dateFormatter.date(from: "\(year)-\(month)-01")
        let daysDiff =  Calendar.current.dateComponents([ .day ], from: date, to: endDate!)
        return daysDiff.day ?? 0
    }
    
}

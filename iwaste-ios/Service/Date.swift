//
//  Date.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 04/11/20.
//

import UIKit

let calender = Calendar.current

extension Date {
    
    var year: Int {
        return calender.component(.year, from: self)
    }
    
    var week: Int {
        return calender.component(.weekOfYear, from: self)
    }
    
    var weekOfMonth: Int {
        return calender.component(.weekOfMonth, from: self)
    }
    
    var weekAndYear: DateComponents {
        return calender.dateComponents([.weekOfYear, .year], from: self)
    }
    
    var weekDay: Int {
        return calender.component(.weekday, from: self)
    }
    
    var startOfDay: Date {
        return calender.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var component = DateComponents()
        component.day = 1
        component.second = -1
        
        return calender.date(byAdding: component, to: Date().startOfDay)!
    }
    
    func add(_ x: Int) -> Date {
        let cal = Calendar.current
        
        return cal.date(byAdding: .day, value: x, to: Date())!
    }
    
}

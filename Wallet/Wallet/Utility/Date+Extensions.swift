//
//  Date+Extensions.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 13.03.2023.
//

import Foundation

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    static func randomDate(dayRange: Range<Int>) -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: now)

        components.year = 2023
        components.month = 12
        components.day = Int.random(in: dayRange)
        components.hour = Int.random(in: 0..<24)
        components.minute = Int.random(in: 0..<60)

        return gregorian.date(from: components) ?? now
    }
}

//
//  DateExt.swift
//  Contexto
//
//  Created by Andreas Ink on 4/26/22.
//

import SwiftUI

extension String {

    func toDate(withFormat format: String = "yyyy/MM/dd HH:mm:ss")-> Date? {

        let dateFormatter = DateFormatter()
       // dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
       // dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
extension Date {
    static func dates(from fromDate: Date, to toDate: Date, interval: Int) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .hour, value: interval, to: date) else { break }
            date = newDate
        }
        return dates
    }
    static func datesHourly(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .hour, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

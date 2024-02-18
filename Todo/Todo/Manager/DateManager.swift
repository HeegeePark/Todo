//
//  DateManager.swift
//  Todo
//
//  Created by 박희지 on 2/15/24.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    
    private init() { }
    
    private let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 dd일 a HH:mm"
        format.timeZone = TimeZone(identifier: "Asia/Seoul")
        return format
    }()
    
    func toString(date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func toDate(string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    func todayDateRange() -> (star: Date, end: Date) {
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = {
          let components = DateComponents(day: 1, second: -1)
          return Calendar.current.date(byAdding: components, to: start)!
        }()
        return (start, end)
    }
}


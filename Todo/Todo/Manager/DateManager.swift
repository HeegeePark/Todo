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
    
    func toString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func toDate(string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}


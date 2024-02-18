//
//  ListType.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit
import RealmSwift

enum ListType: String, CaseIterable {
    case today
    case schedule
    case all
    case flag
    case done
    
    static let repository = TodoModelRepository()
    
    var title: String {
        switch self {
        case .today:
            return "오늘"
        case .schedule:
            return "예정"
        case .all:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .done:
            return "완료됨"
        }
    }
    
    var imageString: String {
        switch self {
        case .today:
            return "calendar"
        case .schedule:
            return "calendar"
        case .all:
            return "tray.fill"
        case .flag:
            return "flag.fill"
        case .done:
            return "checkmark"
        }
    }
    
    var imageColor: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .schedule:
            return .systemRed
        case .all:
            return .lightGray
        case .flag:
            return .systemYellow
        case .done:
            return .systemGray
        }
    }
    
    var todoList: Results<TodoModel> {
        // TODO: 나머지 타입들도 맞게 필터링하기
        switch self {
        case .done:
            return ListType.repository.fetchCompleted()
        default:
            return ListType.repository.fetch()
        }
    }
    
    var totalCount: Int {
        return todoList.count
    }
}

extension ListType {
    func asImage() -> UIImage? {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .light)
        return UIImage(systemName: imageString, withConfiguration: imageConfig)
    }
}

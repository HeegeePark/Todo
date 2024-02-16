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
    
    var totalCount: Int {
        let realm = try! Realm()
        switch self {
        case .all:
            let todos = realm.objects(TodoModel.self)
            return todos.count
        default:
            let todos = realm.objects(TodoModel.self).where {
                $0.tag == rawValue
            }
            return todos.count
        }
    }
}

extension ListType {
    func asImage() -> UIImage? {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .light)
        return UIImage(systemName: imageString, withConfiguration: imageConfig)
    }
}

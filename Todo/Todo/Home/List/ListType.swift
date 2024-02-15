//
//  ListType.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit

enum ListType: String, CaseIterable {
    case today = "오늘"
    case schedule = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case done = "완료됨"
    
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
}

extension ListType {
    func asImage() -> UIImage? {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .light)
        return UIImage(systemName: imageString, withConfiguration: imageConfig)
    }
}

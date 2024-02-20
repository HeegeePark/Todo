//
//  TodoType.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit

enum TodoType: String, CaseIterable {
    case content
    case deadline
    case tag
    case priority
    case image
    
    var cellText: [String] {
        switch self {
        case .content:
            return ["제목", "메모"]
        case .deadline:
            return ["마감일"]
        case .tag:
            return ["태그"]
        case .priority:
            return ["우선 순위"]
        case .image:
            return ["이미지 추가"]
        }
    }
    
    var numberOfRows: Int {
        return cellText.count
    }
    
    var nextToPush: PassDataProtocol? {
        switch self {
        case .content:
            return nil
        case .deadline:
            return DateViewController()
        case .tag:
            return TagViewController()
        case .priority:
            return PriorityViewController()
        case .image:
            return ImageViewController()
        }
    }
}

extension TodoType {
    static func rowHeight(indexPath: IndexPath) -> CGFloat {
        return indexPath == [0, 1] ? 100: 50
    }
    
    static subscript(indexPath: IndexPath) -> String {
        return TodoType.allCases[indexPath.section].cellText[indexPath.row]
    }
}

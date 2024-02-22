//
//  IconColorType.swift
//  Todo
//
//  Created by 박희지 on 2/22/24.
//

import UIKit

enum IconColorType: Int, CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case brown
    
    var color: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .orange:
            return .systemOrange
        case .yellow:
            return .systemYellow
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .purple:
            return .systemPurple
        case .brown:
            return .systemBrown
        }
    }
}

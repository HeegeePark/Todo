//
//  UIStackView+Extension.swift
//  Todo
//
//  Created by 박희지 on 2/17/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ subviews: UIView...) {
        for subview in subviews {
            self.addArrangedSubview(subview)
        }
    }
}

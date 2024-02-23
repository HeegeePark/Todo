//
//  IconImageView.swift
//  Todo
//
//  Created by 박희지 on 2/22/24.
//

import UIKit

class IconButton: UIButton {
    var imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .white
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func configure(iconStr: String, color: UIColor) {
        let image = UIImage(systemName: iconStr, withConfiguration: imageConfig)
        self.setImage(image, for: .normal)
        self.backgroundColor = color
    }
}

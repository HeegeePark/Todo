//
//  SelectColorCollectionViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/23/24.
//

import UIKit

class SelectColorCollectionViewCell: UICollectionViewCell {
    let colorView = UIView()
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor = isSelected ? asCGColor(.systemGray4): asCGColor(.clear)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(colorView)
        
        let inset: CGFloat = 6
        colorView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(inset)
        }
        
        contentView.layer.cornerRadius = contentView.frame.width / 2
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = asCGColor(.clear)
        colorView.layer.cornerRadius = (contentView.frame.width - 2 * inset) / 2
    }
    
    func setColor(_ color: UIColor) {
        colorView.backgroundColor = color
    }
    
    func setSelected() {
        isSelected.toggle()
    }
    
    func asCGColor(_ color: UIColor) -> CGColor {
        return color.cgColor
    }
}

//
//  TodoListCollectionViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit
import SnapKit

class TodoListCollectionViewCell: UICollectionViewCell {
    
    let icon = UIButton()
    let totalCountLabel = UILabel()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(image: UIImage?, imageColor: UIColor, count: Int, title: String) {
        icon.setImage(image, for: .normal)
        icon.backgroundColor = imageColor
        totalCountLabel.text = String(count)
        titleLabel.text = title
    }
    
    func configureHierarchy() {
        contentView.addSubview(icon)
        contentView.addSubview(totalCountLabel)
        contentView.addSubview(titleLabel)
    }
    
    func configureLayout() {
        icon.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.size.equalTo(30)
        }
        
        totalCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(icon)
            make.trailing.equalTo(contentView).inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon)
            make.top.greaterThanOrEqualTo(icon.snp.bottom).offset(10)
            make.bottom.equalTo(contentView).inset(10)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        
        // 아이콘
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .light)
        let image = UIImage(systemName: "heart", withConfiguration: imageConfig)
        icon.setImage(image, for: .normal)
        icon.layer.cornerRadius = 15
        icon.tintColor = .white
        
        // todo 수
        totalCountLabel.text = "0"
        totalCountLabel.font = .boldSystemFont(ofSize: 24)
        totalCountLabel.textColor = .white
        
        // 타이틀
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .lightText
    }
}

//
//  TodoSubTitleStyleTableViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/15/24.
//

import UIKit
import SnapKit

class TodoSubTitleStyleTableViewCell: UITableViewCell {
    let rightImageView = UIImageView()
    
    override var imageView: UIImageView {
        return rightImageView
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        detailTextLabel?.text = ""
    }
    
    func configure() {
        contentView.addSubview(rightImageView)
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(contentView)
            make.size.equalTo(30)
        }
    }
}

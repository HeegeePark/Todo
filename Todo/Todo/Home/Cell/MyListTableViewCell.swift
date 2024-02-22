//
//  MyListTableViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/20/24.
//

import UIKit
import SnapKit

class MyListTableViewCell: UITableViewCell {
    
    let iconButton = IconButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconButton)
        configureLayout()
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        iconButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
            make.size.equalTo(30)
        }
        
        textLabel!.snp.makeConstraints { make in
            make.leading.equalTo(iconButton.snp.trailing).offset(10)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configureView() {
        imageView?.backgroundColor = .blue
        textLabel?.font = .boldSystemFont(ofSize: 20)
        detailTextLabel?.font = .boldSystemFont(ofSize: 18)
        detailTextLabel?.textColor = .lightText
        imageView?.tintColor = .white
        accessoryType = .disclosureIndicator
    }
    
    func bindData(mylist: MyListModel) {
        textLabel?.text = mylist.title
        let color = IconColorType.allCases[mylist.color].color
        iconButton.configure(iconStr: mylist.icon, color: color)
        detailTextLabel?.text = "\(mylist.todos.count)"
    }
}

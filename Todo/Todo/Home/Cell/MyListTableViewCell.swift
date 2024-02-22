//
//  MyListTableViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/20/24.
//

import UIKit

class MyListTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        textLabel?.text = "사야 함"
        textLabel?.font = .boldSystemFont(ofSize: 20)
        detailTextLabel?.text = "4"
        detailTextLabel?.font = .boldSystemFont(ofSize: 18)
        detailTextLabel?.textColor = .lightText
        imageView?.image = UIImage(systemName: "list")
        imageView?.layer.cornerRadius = (imageView?.frame.width ?? 30) / 2
        accessoryType = .disclosureIndicator
    }
    
    func bindData(mylist: MyListModel) {
        textLabel?.text = mylist.title
        imageView?.image = UIImage(systemName: mylist.icon)
        detailTextLabel?.text = "\(mylist.todos.count)"
    }
}

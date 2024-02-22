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
        textLabel?.font = .boldSystemFont(ofSize: 20)
        detailTextLabel?.font = .boldSystemFont(ofSize: 18)
        detailTextLabel?.textColor = .lightText
        imageView?.layer.cornerRadius = (imageView?.frame.width ?? 30) / 2
        accessoryType = .disclosureIndicator
    }
    
    func bindData(mylist: MyListModel) {
        textLabel?.text = mylist.title
        imageView?.image = UIImage(systemName: mylist.icon)
        detailTextLabel?.text = "\(mylist.todos.count)"
    }
}

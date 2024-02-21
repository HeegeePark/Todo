//
//  MyListView.swift
//  Todo
//
//  Created by 박희지 on 2/20/24.
//

import UIKit
import SnapKit

class MyListView: BaseView {
    let titleLabel = UILabel()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func configureHierarchy() {
        self.addSubViews(titleLabel, tableView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.top.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
//            make.horizontalEdges.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    override func configureView() {
        titleLabel.text = "나의 목록"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        configureTableView()
    }
    
    func configureTableView() {
        tableView.rowHeight = 50
        tableView.backgroundColor = .gray
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
    }
}

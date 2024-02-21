//
//  MyListView.swift
//  Todo
//
//  Created by 박희지 on 2/20/24.
//

import UIKit
import SnapKit

protocol DynamicHeight where Self: UIViewController {
    func dynamicHeight(height: CGFloat)
}

class MyListView: BaseView {
    let titleLabel = UILabel()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var delegate: DynamicHeight?
    
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
            make.horizontalEdges.bottom.equalToSuperview()
//            make.height.equalTo(300)
        }
    }
    
    override func configureView() {
        titleLabel.text = "나의 목록"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.sizeToFit()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        super.systemLayoutSizeFitting(targetSize)
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: frame.origin.y, width: tableView.frame.width, height: 1400)
        
        tableView.layoutIfNeeded()
        
        let dynamicSize = CGSize(width: tableView.frame.width, height: tableView.frame.height + titleLabel.frame.height)
        
        delegate?.dynamicHeight(height: dynamicSize.height)
        
        return dynamicSize
    }
}

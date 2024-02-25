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
    let checkButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkButton.isHidden = true
    }
    
    private func configureHierarchy() {
        contentView.addSubview(iconButton)
        contentView.addSubview(checkButton)
    }
    
    private func configureLayout() {
        iconButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
            make.size.equalTo(30)
        }
        
        // TODO: 이거 왜 되다가 안될까유? ㅡㅡ+
        textLabel!.snp.makeConstraints { make in
            make.leading.equalTo(iconButton.snp.trailing).offset(10)
            make.centerY.equalTo(contentView)
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
            make.size.equalTo(30)
        }
    }
    
    private func configureView() {
        imageView?.backgroundColor = .blue
        textLabel?.font = .boldSystemFont(ofSize: 20)
        detailTextLabel?.font = .boldSystemFont(ofSize: 18)
        detailTextLabel?.textColor = .lightText
        imageView?.tintColor = .white
        accessoryType = .disclosureIndicator
        checkButton.isHidden = true
        let config = UIImage.SymbolConfiguration(scale: .large)
        checkButton.setImage(UIImage(systemName: "checkmark")?.withConfiguration(config), for: .normal)
        checkButton.tintColor = .systemBlue
    }
    
    func bindData(mylist: MyListModel) {
        textLabel?.text = mylist.title
        let color = IconColorType.allCases[mylist.color].color
        iconButton.configure(iconStr: "list.dash", color: color)
        detailTextLabel?.text = "\(mylist.todos.count)"
    }
    
    // 할 일 등록 시, 나의 목록 선택할 때만 호출
    func activateCheckButton(isSelectd: Bool) {
        accessoryType = .none
        detailTextLabel?.isHidden = true
        checkButton.isHidden = !isSelectd
    }
}

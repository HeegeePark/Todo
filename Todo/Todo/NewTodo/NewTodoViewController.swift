//
//  NewTodoViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit

protocol PassDataProtocol where Self: UIViewController {
    var passData: ((String)-> Void)? { get set }
}

class NewTodoViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    enum TodoType: Int, CaseIterable {
        case content
        case deadline
        case tag
        case priority
        case image
        
        var cellText: [String] {
            switch self {
            case .content:
                return ["제목", "메모"]
            case .deadline:
                return ["마감일"]
            case .tag:
                return ["태그"]
            case .priority:
                return ["우선 순위"]
            case .image:
                return ["이미지 추가"]
            }
        }
        
        var numberOfRows: Int {
            return cellText.count
        }
        
        var nextToPush: PassDataProtocol? {
            switch self {
            case .content:
                return nil
            case .deadline:
                return DateViewController()
            case .tag:
                return TagViewController()
            case .priority:
                return nil
            case .image:
                return nil
            }
        }
        
        static func rowHeight(indexPath: IndexPath) -> CGFloat {
            return indexPath == [0, 1] ? 100: UITableView.automaticDimension
        }
        
        static subscript(indexPath: IndexPath) -> String {
            return TodoType.allCases[indexPath.section].cellText[indexPath.row]
        }
    }
    
    var data: [String] = Array(repeating: "", count: TodoType.allCases.count)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "새로운 할 일"
        
        let leftItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        rightItem.isEnabled = false
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.register(TodoCell.self, forCellReuseIdentifier: "cell")
    }

}

extension NewTodoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TodoType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TodoType.rowHeight(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoType.allCases[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoCell
        cell.selectionStyle = .none
        cell.textLabel?.text = TodoType[indexPath]
        cell.textLabel?.font = .systemFont(ofSize: 13)
        
        if TodoType.allCases[indexPath.section] == .content {
            cell.textLabel?.textColor = .lightText
        } else {
            cell.textLabel?.textColor = .white
            print("in Cell:", data[indexPath.section])
            cell.detailTextLabel?.text = data[indexPath.section]
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = TodoType.allCases[indexPath.section]
        
        switch type {
        case .content:
            break
        default:
            let vc = type.nextToPush!
            
            vc.passData = { data in
                print(data)
                self.data[indexPath.section] = data
                self.tableView.reloadData()
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

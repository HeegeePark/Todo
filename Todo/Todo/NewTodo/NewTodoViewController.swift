//
//  NewTodoViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit
import RealmSwift

protocol PassDataProtocol where Self: UIViewController {
    var passData: ((String)-> Void)? { get set }
}

class NewTodoViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var content: [String] = Array(repeating: "", count: TodoType.content.numberOfRows) {
        didSet {
            tableView.reloadData()
        }
    }
    
    var fromPassData: [String] = Array(repeating: "", count: TodoType.allCases.count) {
        didSet {
            tableView.reloadData()
        }
    }
    
    var addHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "새로운 할 일"
        
        let leftItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        let realm = try! Realm()
        
        let todo = asTodoModel()
        
        try! realm.write {
            realm.add(todo)
        }
        
        addHandler?()
        dismiss(animated: true)
    }
    
    func asTodoModel() -> TodoModel {
        let combined: [String?] = (content + fromPassData[1...]).map {
            $0.isEmpty ? nil: $0
        }
        return TodoModel(title: combined[0]!,
                         memo: combined[1],
                         deadline: DateManager.shared.toDate(string: combined[2] ?? ""),
                         tag: combined[3],
                         priority: combined[4],
                         image: combined[5])
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
        tableView.register(TodoSubTitleStyleTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TodoTextFieldTableViewCell.self, forCellReuseIdentifier: "tfCell")
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
        let type = TodoType.allCases[indexPath.section]
        
        switch type {
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tfCell", for: indexPath) as! TodoTextFieldTableViewCell
            cell.selectionStyle = .none
            
            cell.configure(index: indexPath.row, placeholder: TodoType[indexPath])
            cell.todoText = content[indexPath.row]
            cell.delegate = self
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoSubTitleStyleTableViewCell
            cell.selectionStyle = .none
            
            cell.textLabel?.text = TodoType[indexPath]
            cell.textLabel?.font = .systemFont(ofSize: 13)
            cell.textLabel?.textColor = .white
            cell.detailTextLabel?.text = fromPassData[indexPath.section]
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = TodoType.allCases[indexPath.section]
        
        switch type {
        case .content:
            break
        default:
            let vc = type.nextToPush!
            
            vc.passData = { data in
                self.fromPassData[indexPath.section] = data
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewTodoViewController: TextFieldCellDelegate {
    func didEditTodoText(_ newText: String, at index: Int) {
        content[index] = newText
    }
}

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
    
    let repository = TodoModelRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "새로운 할 일"
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.leftBarButtonItem = cancelButton
        
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        guard isFilledInTitle() else {
            showToast("제목 입력은 필수입니다. 🙏")
            return
        }
        
        let todo = asTodoModel()
        repository.createItem(todo)
        
        addHandler?()
        dismiss(animated: true)
    }
    
    func isFilledInTitle() -> Bool {
        return !content.first!.isEmpty
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
        tableView.register(NewTodoSubTitleStyleTableViewCell.self, forCellReuseIdentifier: NewTodoSubTitleStyleTableViewCell.identifier)
        tableView.register(NewTodoTextFieldTableViewCell.self, forCellReuseIdentifier: NewTodoTextFieldTableViewCell.identifier)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: NewTodoTextFieldTableViewCell.identifier, for: indexPath) as! NewTodoTextFieldTableViewCell
            cell.selectionStyle = .none
            
            cell.configure(index: indexPath.row, placeholder: TodoType[indexPath])
            cell.todoText = content[indexPath.row]
            cell.delegate = self
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewTodoSubTitleStyleTableViewCell.identifier, for: indexPath) as! NewTodoSubTitleStyleTableViewCell
            
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

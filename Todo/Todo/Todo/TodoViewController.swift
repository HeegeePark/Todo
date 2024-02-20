//
//  TodoViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit

protocol PassDataProtocol where Self: UIViewController {
    var passData: ((Any)-> Void)? { get set }
}

class TodoViewController: BaseViewController {
    
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
    
    var selectedImage: UIImage? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var deleteButtonTapHandler: (() -> Void)?
    var doneButtonTapHandler: (() -> Void)?
    
    let repository = TodoModelRepository()
    
    let editType: TodoEditType
    
    init(editType: TodoEditType) {
        self.editType = editType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        bindIfUpdateMode()
    }
    
    func bindIfUpdateMode() {
        switch editType {
        case .create:
            return
        case .update(let todo):
            content[0] = todo.title
            
            if let memo = todo.memo {
                content[1] = memo
            }
            
            if let deadline = todo.deadline {
                let toString = DateManager.shared.toString(date: deadline, format: "yyyy년 MM월 dd일")
                fromPassData[1] = toString
            }
            
            if let tag = todo.tag {
                fromPassData[2] = tag
            }
            
            if let priority = todo.priority {
                fromPassData[3] = priority
            }
            
            if let image = todo.image {
                // TODO: UIImage 띄우기로 바꾸기
                selectedImage = ImageManager.shared.loadImageFromDocument(filename: "\(todo.id)")
            }
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = editType.title
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.leftBarButtonItem = cancelButton
        
        let deleteButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonClicked))
        deleteButton.tintColor = .systemRed
        
        let doneButton = UIBarButtonItem(title: editType.doneButtonTitle, style: .plain, target: self, action: #selector(doneButtonClicked))
        
        switch editType {
        case .create:
            navigationItem.rightBarButtonItem = doneButton
        case .update(_):
            navigationItem.rightBarButtonItems = [doneButton, deleteButton]
        }
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func deleteButtonClicked() {
        let ok = UIAlertAction(title: "삭제", style: .default) { _ in
            self.deleteButtonTapHandler?()
            self.dismiss(animated: true)
        }
        presentAlert(title: "할 일 삭제하기", message: "정말 할 일을 삭제하시겠습니까?", actions: ok)
    }
    
    @objc func doneButtonClicked() {
        guard isFilledInTitle() else {
            showToast("제목 입력은 필수입니다. 🙏")
            return
        }
        
        switch editType {
        case .create:
            let todo = asTodoModel()
            repository.createItem(todo)
            
            if let selectedImage {
                ImageManager.shared.saveImageToDocument(image: selectedImage, filename: "\(todo.id)")
            }
            
        case .update(let todo):
            let updated = asTodoModel()
            repository.updateItem(id: todo.id, updated: updated)
        }
        
        doneButtonTapHandler?()
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
        tableView.register(TodoSubTitleStyleTableViewCell.self, forCellReuseIdentifier: TodoSubTitleStyleTableViewCell.identifier)
        tableView.register(TodoTextFieldTableViewCell.self, forCellReuseIdentifier: TodoTextFieldTableViewCell.identifier)
    }

}

extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoTextFieldTableViewCell.identifier, for: indexPath) as! TodoTextFieldTableViewCell
            cell.selectionStyle = .none
            
            cell.configure(index: indexPath.row, placeholder: TodoType[indexPath])
            cell.todoText = content[indexPath.row]
            cell.delegate = self
            
            return cell
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoSubTitleStyleTableViewCell.identifier, for: indexPath) as! TodoSubTitleStyleTableViewCell
            
            cell.textLabel?.text = TodoType[indexPath]
            cell.textLabel?.font = .systemFont(ofSize: 13)
            cell.textLabel?.textColor = .white
            if let selectedImage {
                cell.imageView.image = selectedImage
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoSubTitleStyleTableViewCell.identifier, for: indexPath) as! TodoSubTitleStyleTableViewCell
            
            cell.textLabel?.text = TodoType[indexPath]
            cell.textLabel?.font = .systemFont(ofSize: 13)
            cell.textLabel?.textColor = .white
            cell.imageView.image = nil
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
        case .image:
            let vc = type.nextToPush!
        
            vc.passData = { data in
                self.selectedImage = data as? UIImage
                self.fromPassData[indexPath.section] = "image exist"
            }
            
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = type.nextToPush!
        
            vc.passData = { data in
                self.fromPassData[indexPath.section] = data as! String
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TodoViewController: TextFieldCellDelegate {
    func didEditTodoText(_ newText: String, at index: Int) {
        content[index] = newText
    }
}

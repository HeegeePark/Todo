//
//  TodoListViewController.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit
import RealmSwift

protocol TodoListFetchable where Self: UIViewController {
    var type: TodoListModeType { get }
}

class TodoListViewController: BaseViewController, TodoListFetchable {
    
    let tableView = UITableView()
    
    var todoList: Results<TodoModel>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    let repository = TodoModelRepository()
    
    var type: TodoListModeType
    
    init(mode: TodoListModeType) {
        self.type = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoList = type.todoList
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
        configureNavigationBar()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
    
    func configureNavigationBar() {
        navigationItem.title = type.title
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        
        let action1 = UIAction(title: "마감일 순", handler: { [self] _ in
            let results = type.todoList
            todoList = repository.fetchSorted(results: results, "deadline")
        })
        let action2 = UIAction(title: "제목 순", handler: { [self] _ in
            let results = type.todoList
            todoList = repository.fetchSorted(results: results, "title")
        })
        let action3 = UIAction(title: "우선순위 낮음", handler: { [self] _ in
            let results = type.todoList
            todoList = repository.fetchFiltered(results: results, key: "priority", value: "low")
        })
        
        right.menu = UIMenu(title: "정렬 또는 필터링", options: .displayInline, children: [action1, action2, action3])
        navigationItem.rightBarButtonItem = right
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as! TodoListTableViewCell
        
        let row = todoList[indexPath.row]
        cell.bindTodo(model: row)
        
        cell.checkButtonTapHandler = { isDone in
            self.repository.updateCheck(item: row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = todoList[indexPath.row]
        let vc = TodoViewController(editType: .update(todo: row))
        
        vc.deleteButtonTapHandler = {
            self.repository.deleteItem(object: row)
            self.tableView.reloadData()
        }
        
        vc.doneButtonTapHandler = {
            self.tableView.reloadData()
        }
        
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal, title: "flag") { action, view, completion in
            let row = self.todoList[indexPath.row]
            self.repository.updateFlag(item: row)
            self.tableView.reloadData()
            completion(true)
        }
        flag.backgroundColor = .systemYellow
        flag.image = UIImage(systemName: "flag.fill")
        
        return UISwipeActionsConfiguration(actions: [flag])
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = todoList[indexPath.row]
            repository.deleteItem(object: row)
            tableView.reloadData()
        }
    }
}

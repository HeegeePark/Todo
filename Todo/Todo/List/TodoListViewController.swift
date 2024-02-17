//
//  TodoListViewController.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit
import RealmSwift

class TodoListViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var todoList: Results<TodoModel>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readRealm()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mainCell")
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Todo 리스트"
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        
        let action1 = UIAction(title: "마감일 순", handler: { _ in
            let realm = try! Realm()
            self.todoList = realm.objects(TodoModel.self).sorted(byKeyPath: "deadline", ascending: true)
        })
        let action2 = UIAction(title: "제목 순", handler: { _ in
            let realm = try! Realm()
            self.todoList = realm.objects(TodoModel.self).sorted(byKeyPath: "title", ascending: true)
        })
        let action3 = UIAction(title: "우선순위 낮음", handler: { _ in
            let realm = try! Realm()
            self.todoList = realm.objects(TodoModel.self).where {
                $0.priority == "low"
            }
        })
        
        right.menu = UIMenu(title: "정렬 또는 필터링", options: .displayInline, children: [action1, action2, action3])
        navigationItem.rightBarButtonItem = right
    }
    
    func readRealm() {
        let realm = try! Realm()
        todoList = realm.objects(TodoModel.self)
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell")!
        
        let row = todoList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = row.dataToShow()
        
        return cell
    }
}

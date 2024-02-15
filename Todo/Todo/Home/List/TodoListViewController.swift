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
    
    func readRealm() {
        let realm = try! Realm()
        
        todoList = realm.objects(TodoModel.self)
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Todo 리스트"
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(rightButtonClicked))
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func rightButtonClicked() {   
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

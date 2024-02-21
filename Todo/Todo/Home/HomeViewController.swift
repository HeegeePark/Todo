//
//  HomeViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        cv.setLayout(inset: 12, spacing: 12, ratio: 0.45, colCount: 2)
        cv.isScrollEnabled = false
        cv.register(TodoListStatusCollectionViewCell.self, forCellWithReuseIdentifier: "statusCell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var myListView: MyListView = {
        let view = MyListView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(myListView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        myListView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        configureToolBar()
    }
    
    func configureNavigationBar() {
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = right
    }
    
    func configureToolBar() {
        navigationController?.isToolbarHidden = false
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let newButton: UIButton = {
            var config = UIButton.Configuration.plain()
            config.imagePadding = 8
            let action = UIAction(title: "새로운 할 일", image: UIImage(systemName: "plus.circle.fill")) { _ in
                self.newTodoButtonClicked()
            }
            let button = UIButton(configuration: config, primaryAction: action)
            return button
        }()
        
        let newTodo = UIBarButtonItem(customView: newButton)
        let addList = UIBarButtonItem(title: "목록 추가", image: nil, target: self, action: nil)
        toolbarItems = [newTodo, flexibleSpace, addList]
    }
    
    private func newTodoButtonClicked() {
        let vc = TodoViewController(editType: .create)
        
        vc.doneButtonTapHandler = {
            self.collectionView.reloadData()
        }
        
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statusCell", for: indexPath) as! TodoListStatusCollectionViewCell
        
        let list = ListType.allCases[indexPath.item]
        cell.bind(image: list.asImage(), imageColor: list.imageColor, count: list.totalCount, title: list.title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = ListType.allCases[indexPath.item]
        
        let vc = TodoListViewController(type: type)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier, for: indexPath) as! MyListTableViewCell
        
        return cell
    }
}

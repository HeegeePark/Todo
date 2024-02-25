//
//  SelectMyListViewController.swift
//  Todo
//
//  Created by 박희지 on 2/25/24.
//

import UIKit
import SnapKit
import RealmSwift

class SelectMyListViewController: BaseViewController, PassDataProtocol {
    private let descriptionLabel = UILabel()
    private let tableView = UITableView()
    
    var passData: ((Any) -> Void)?
    
    let myListRepository = MyListModelRepository()
    lazy var myList: Results<MyListModel>! = myListRepository.fetch()
    
    var selectedRow: Int = 0 {
        didSet {
            updateDescriptionLabel()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        passData?(myList[selectedRow])
    }
    
    func updateDescriptionLabel() {
        let mylist = myList[selectedRow]
        descriptionLabel.text = "미리 알림이 '\(mylist.title)'에 생성됩니다."
    }
    
    override func configureHierarchy() {
        view.addSubViews(descriptionLabel, tableView)
    }
    
    override func configureLayout() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        configureNavigationBar()
        configureTableView()
        updateDescriptionLabel()
        descriptionLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
    }
    
    func configureNavigationBar() {
        navigationItem.title = "목록"
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
    }
}

extension SelectMyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier, for: indexPath) as! MyListTableViewCell
        let mylist = myList[indexPath.row]
        cell.selectionStyle = .none
        cell.bindData(mylist: mylist)
        
        let isSelcted = selectedRow == indexPath.row
        cell.activateCheckButton(isSelectd: isSelcted)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
}

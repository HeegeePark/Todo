//
//  HomeViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let newTodoButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(newTodoButton)
    }
    
    override func configureLayout() {
        newTodoButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black
        
        navigationController?.isToolbarHidden = false
        // TODO: title 뜨게 고치기
        let newTodo = UIBarButtonItem(title: "새로운 할 일", image: UIImage(systemName: "plus.circle.fill"), target: self, action: #selector(newTodoButtonClicked))
        toolbarItems = [newTodo]
    }
    
    @objc func newTodoButtonClicked() {
        let vc = UINavigationController(rootViewController: NewTodoViewController())
        
        present(vc, animated: true)
    }

}

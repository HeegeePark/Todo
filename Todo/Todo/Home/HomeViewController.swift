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
//            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        newTodoButton.setTitle("새로운 할 일", for: .normal)
        newTodoButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        newTodoButton.addTarget(self, action: #selector(newTodoButtonClicked), for: .touchUpInside)
    }
    
    @objc func newTodoButtonClicked() {
        let vc = NewTodoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

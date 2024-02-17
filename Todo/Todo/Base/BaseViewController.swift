//
//  BaseViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit
import SnapKit
import Toast

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
    }
    
    func configureLayout() {
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func showToast(_ message: String) {
        view.makeToast(message, duration: 3, position: .center)
    }
}

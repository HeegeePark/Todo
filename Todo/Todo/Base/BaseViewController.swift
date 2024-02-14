//
//  BaseViewController.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit
import SnapKit

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
}

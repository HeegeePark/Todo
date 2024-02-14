//
//  TagViewController.swift
//  Todo
//
//  Created by 박희지 on 2/15/24.
//

import UIKit

class TagViewController: BaseViewController, PassDataProtocol {
    let tagTextField = UITextField()
    
    var passData: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        passData?(tagTextField.text!)
    }
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    override func configureView() {
        super.configureView()
        tagTextField.placeholder = "태그를 입력해주세요"
        tagTextField.keyboardType = .alphabet
    }
}

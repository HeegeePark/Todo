//
//  TodoTextFieldTableViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func didEditTodoText(_ newText: String, at index: Int)
}

class TodoTextFieldTableViewCell: UITableViewCell {
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.font = .systemFont(ofSize: 13)
        return tf
    }()
    
    weak var delegate: TextFieldCellDelegate?
    
    var todoText: String = "" {
        didSet {
            textField.text = todoText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(textField)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
    }
    
    func configure(index: Int, placeholder: String) {
        textField.tag = index
        textField.placeholder = placeholder
    }
}

extension TodoTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEditTodoText(textField.text ?? "", at: textField.tag)
    }
}

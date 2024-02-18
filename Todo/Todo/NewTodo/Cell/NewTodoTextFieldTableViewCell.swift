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

class NewTodoTextFieldTableViewCell: BaseTableViewCell {
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 13)
        tf.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChanacge() {
        delegate?.didEditTodoText(textField.text ?? "", at: textField.tag)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
    }
    
    func configure(index: Int, placeholder: String) {
        textField.tag = index
        textField.placeholder = placeholder
    }
}

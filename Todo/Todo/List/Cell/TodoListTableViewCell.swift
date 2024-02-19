//
//  TodoListTableViewCell.swift
//  Todo
//
//  Created by 박희지 on 2/17/24.
//

import UIKit
import SnapKit

class TodoListTableViewCell: BaseTableViewCell {
    
    private let checkButton = UIButton()
    private let stackView = UIStackView()
    private let firstLineHorizontalStackView = UIStackView()
    private let priorityLabel = UILabel()
    private let titleLabel = UILabel()
    private let memoLabel = UILabel()
    private let thirdLineHorizontalStackView = UIStackView()
    private let deadLineLabel = UILabel()
    private let tagLabel = UILabel()
    private let subImageView = UIImageView()
    
    var isDone: Bool = false {
        didSet {
            configureCheckButton()
        }
    }
    
    var checkButtonTapHandler: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindTodo(model: TodoModel) {
        var preprocessed = PreprocessedTodoModel(model: model)
        
        isDone = preprocessed.isDone
        titleLabel.text = preprocessed.title
        
        configureOptionalData(priorityLabel, data: preprocessed.priority)
        configureOptionalData(memoLabel, data: preprocessed.memo)
        configureOptionalData(deadLineLabel, data: preprocessed.deadline)
        configureOptionalData(tagLabel, data: preprocessed.tag)
        
        if let image = ImageManager.shared.loadImageFromDocument(filename: "\(model.id)") {
            subImageView.image = image
        }
    }
    
    @objc private func checkButtonTapped() {
        isDone.toggle()
        checkButtonTapHandler?(isDone)
    }
    
    private func configureCheckButton() {
        checkButton.isSelected = isDone
        checkButton.tintColor = isDone ? .systemBlue: .lightText
        titleLabel.textColor = isDone ? .lightText: .white
    }
    
    private func configureOptionalData<T: UILabel>(_ label: T, data: String?) {
        guard let data else {
            label.isHidden = true
            return
        }
        label.isHidden = false
        label.text = data
        let size = label.sizeThatFits(contentView.frame.size)
        label.frame.size = size
        label.snp.remakeConstraints { make in
            make.size.equalTo(label.frame.size)
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(checkButton, stackView, subImageView)
        stackView.addArrangedSubViews(firstLineHorizontalStackView, memoLabel, thirdLineHorizontalStackView)
        firstLineHorizontalStackView.addArrangedSubViews(priorityLabel, titleLabel)
        thirdLineHorizontalStackView.addArrangedSubViews(deadLineLabel, tagLabel)
    }
    
    override func configureLayout() {
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).inset(4)
            make.size.equalTo(36)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView)
            make.leading.equalTo(checkButton.snp.trailing)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }
        
        firstLineHorizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        memoLabel.snp.makeConstraints { make in
        }
        
        thirdLineHorizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        deadLineLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(30)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }
        
        subImageView.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(30)
        }
    }
    
    override func configureView() {
        
        checkButton.tintColor = .lightText
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .selected)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 0
        
        [firstLineHorizontalStackView, thirdLineHorizontalStackView].forEach {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 4
        }
        
        priorityLabel.font = .systemFont(ofSize: 15)
        priorityLabel.textColor = .systemBlue
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .white
        
        memoLabel.font = .systemFont(ofSize: 13)
        memoLabel.textColor = .lightText
        memoLabel.numberOfLines = 0
        memoLabel.sizeToFit()
        
        deadLineLabel.font = .systemFont(ofSize: 13)
        deadLineLabel.textColor = .lightText
        
        tagLabel.font = .systemFont(ofSize: 13)
        tagLabel.textColor = .systemBlue
        
        subImageView.contentMode = .scaleAspectFill
    }
}

//
//  AddMyListViewController.swift
//  Todo
//
//  Created by 박희지 on 2/23/24.
//

import UIKit
import SnapKit

class AddMyListViewController: BaseViewController {
    let createListView = UIView()
    let iconButton = IconButton()
    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.addTarget(self, action: #selector(titleTextFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    lazy var colorSelectCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        cv.setLayout(inset: 10, spacing: 10, insetFromSuperView: 12, ratio: 1, colCount: 6)
        cv.isScrollEnabled = false
        cv.register(SelectColorCollectionViewCell.self, forCellWithReuseIdentifier: SelectColorCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var listTitle: String = ""
    var color: UIColor = .red {
        didSet {
            iconButton.backgroundColor = color
        }
    }
    
    var doneButtonTapHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "새로운 목록"
        
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        let done = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = done
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() {
        guard isFilledRequired() else {
            showToast("제목 입력은 필수입니다. 🙏")
            return
        }
        
        // TODO: Realm Create
        
        doneButtonTapHandler?()
        dismiss(animated: true)
    }
    
    @objc func titleTextFieldEditingChanged() {
        listTitle = titleTextField.text ?? ""
    }
    
    func isFilledRequired() -> Bool {
        return !listTitle.isEmpty
    }
    
    override func configureHierarchy() {
        view.addSubViews(createListView, colorSelectCollectionView)
        createListView.addSubViews(iconButton, titleTextField)
    }
    
    override func configureLayout() {
        createListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(200)
        }
        
        iconButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(iconButton.snp.bottom).offset(18)
            make.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
        
        colorSelectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(createListView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(130)
        }
    }
    
    override func configureView() {
        super.configureView()
        createListView.layer.cornerRadius = 18
        createListView.backgroundColor = .secondarySystemBackground
        
        iconButton.imageConfig = .init(pointSize: 50, weight: .bold)
        iconButton.configure(iconStr: "list.dash", color: .red)
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "목록 이름", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        titleTextField.textAlignment = .center
        titleTextField.layer.cornerRadius = 12
        titleTextField.backgroundColor = .systemGray4
        titleTextField.keyboardType = .alphabet
        
        colorSelectCollectionView.layer.cornerRadius = 18
        colorSelectCollectionView.backgroundColor = .secondarySystemBackground
    }

}

extension AddMyListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IconColorType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectColorCollectionViewCell.identifier, for: indexPath) as! SelectColorCollectionViewCell
        
        color = IconColorType.allCases[indexPath.item].color
        cell.setColor(color)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectColorCollectionViewCell.identifier, for: indexPath) as! SelectColorCollectionViewCell
        cell.setSelected()
        
        color = IconColorType.allCases[indexPath.item].color
    }
}

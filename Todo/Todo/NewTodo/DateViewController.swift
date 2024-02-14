//
//  DateViewController.swift
//  Todo
//
//  Created by 박희지 on 2/15/24.
//

import UIKit

class DateViewController: BaseViewController, PassDataProtocol {
    
    let datePicker = UIDatePicker()
    
    var selectedDate: String {
        return DateManager.shared.toString(date: datePicker.date)
    }
    
    var passData: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        passData?(selectedDate)
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
    }
}

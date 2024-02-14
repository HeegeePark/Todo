//
//  ImageViewController.swift
//  Todo
//
//  Created by 박희지 on 2/15/24.
//

import UIKit

class ImageViewController: BaseViewController, PassDataProtocol {
    
    let imageStrings = ["🌟", "❤️", "🔥", "💻"]
    lazy var segmentedControl = UISegmentedControl(items: imageStrings)
    
    var selectedPriority: String {
        return imageStrings[segmentedControl.selectedSegmentIndex]
    }
    
    var passData: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        passData?(selectedPriority)
    }
    
    override func configureHierarchy() {
        view.addSubview(segmentedControl)
    }
    
    override func configureLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        segmentedControl.selectedSegmentIndex = 0
    }
}

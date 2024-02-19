//
//  ImageViewController.swift
//  Todo
//
//  Created by 박희지 on 2/15/24.
//

import UIKit

class ImageViewController: BaseViewController, PassDataProtocol {
    let imageView = UIImageView()
    let addImageButton = UIButton()
    
    var selectedImage: UIImage {
        return imageView.image!
    }
    
    var passData: ((Any) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let image = imageView.image {
            passData?(image)
        }
    }
    
    @objc func addImageButtonClicked() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(addImageButton)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        imageView.contentMode = .scaleAspectFill
        addImageButton.backgroundColor = .darkGray
        addImageButton.setTitle("사진 추가", for: .normal)
        addImageButton.addTarget(self, action: #selector(addImageButtonClicked), for: .touchUpInside)
    }
}

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = pickedImage
        }
        
        dismiss(animated: true)
    }
}

//
//  ImageManager.swift
//  Todo
//
//  Created by 박희지 on 2/20/24.
//

import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    private init() { }
    
    private let fileManager = FileManager.default
    
    func loadImageFromDocument(filename: String) -> UIImage? {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask
        ).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("images/\(filename).jpg")
        
        // 해당 경로에 실제로 파일이 존재하는지 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask
        ).first else { return }
        
        let directoryURL = documentDirectory.appendingPathComponent("images")
        
        if !FileManager.default.fileExists(atPath: directoryURL.path()) {
            // 폴더가 없다면 생성
            do {
                try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: false)
            } catch let error {
                print("fail createing folder", error)
                return
            }
        }
        
        let fileURL = directoryURL.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("fail saving image", error)
        }
    }
}

//
//  PreprocessedTodoModel.swift
//  Todo
//
//  Created by 박희지 on 2/19/24.
//

import Foundation

struct PreprocessedTodoModel {
    let model: TodoModel
    
    lazy var title: String = model.title
    lazy var isDone: Bool = model.isDone
    lazy var memo: String? = model.memo
    lazy var deadline: String? = deadlineToString()
    lazy var tag: String? = model.tag != nil ? "#" + model.tag!: nil
    lazy var priority: String? = priorityToBang()
    lazy var image: String? = model.image
    
    init(model: TodoModel) {
        self.model = model
    }
    
    private func deadlineToString() -> String? {
        guard let deadline = model.deadline else { return nil }
        return DateManager.shared.toString(date: deadline, format: "yyyy. M. dd. ")
    }
    
    private func priorityToBang() -> String? {
        switch model.priority {
        case "low":
            return "!"
        case "medium":
            return "!!"
        case "high":
            return "!!!"
        default:
            return nil
        }
    }
}

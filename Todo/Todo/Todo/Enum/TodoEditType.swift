//
//  TodoEditType.swift
//  Todo
//
//  Created by 박희지 on 2/19/24.
//

import Foundation

enum TodoEditType {
    case create
    case update(todo: TodoModel)
    
    var title: String {
        switch self {
        case .create:
            return "새로운 할 일"
        case .update(let todo):
            return todo.title
        }
    }
    
    var doneButtonTitle: String {
        switch self {
        case .create:
            return "추가"
        case .update(_):
            return "수정"
        }
    }
}

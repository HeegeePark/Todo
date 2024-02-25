//
//  TodoListModeType.swift
//  Todo
//
//  Created by 박희지 on 2/26/24.
//

import Foundation
import RealmSwift

enum TodoListModeType {
    case `default`(ListType)
    case mylist(MyListModel)
    
    static let repository = TodoModelRepository()
    
    var title: String {
        switch self {
        case .default(let listType):
            return listType.title
        case .mylist(let myListModel):
            return myListModel.title
        }
    }
    
    var todoList: Results<TodoModel> {
        switch self {
        case .default(let listType):
            return listType.todoList
        case .mylist(let myListModel):
            return TodoListModeType.repository.fetchTodosByMyList(item: myListModel)
        }
    }
}

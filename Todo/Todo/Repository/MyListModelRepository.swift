//
//  MyListModelRepository.swift
//  Todo
//
//  Created by 박희지 on 2/22/24.
//

import Foundation
import RealmSwift

class MyListModelRepository: BaseRepository<MyListModel> {
    let realm = try! Realm()
    
    func updateTodo(item: MyListModel, todo: TodoModel) {
        do {
            try realm.write {
                item.todos.append(todo)
            }
        } catch {
            print("error")
        }
    }
    
    func deleteTodo(item: MyListModel, todo: TodoModel) {
        do {
            try realm.write {
                let idx = item.todos.firstIndex(of: todo)!
                item.todos.remove(at: idx)
            }
        } catch {
            print("error")
        }
    }
}

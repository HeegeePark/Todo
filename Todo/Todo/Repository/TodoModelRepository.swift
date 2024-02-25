//
//  TodoModelRepository.swift
//  Todo
//
//  Created by 박희지 on 2/19/24.
//

import Foundation
import RealmSwift

class TodoModelRepository: BaseRepository<TodoModel> {
    private let realm = try! Realm()
    
    func fetchCompleted() -> Results<TodoModel> {
        return super.fetch().filter("isDone == true")
    }
    
    func fetchToday() -> Results<TodoModel> {
        let (start, end) = DateManager.shared.todayDateRange()
        return super.fetch().where {
            $0.deadline.contains(start...end)
        }
    }
    
    func fetchSchedule() -> Results<TodoModel> {
        return super.fetch().where {
            $0.deadline > Date()
        }
    }
    
    func fetchFlag() -> Results<TodoModel> {
        return super.fetch().filter("isFlag == true")
    }
    
    func fetchTodosByMyList(item: MyListModel) -> Results<TodoModel> {
        return item.todos.filter("TRUEPREDICATE")
    }
    
    override func updateItem(id: ObjectId, updated: BaseRepository<TodoModel>.Model) {
        do {
            try realm.write {
                realm.create(TodoModel.self,
                             value: [
                                "id": id,
                                "title": updated.title,
                                "memo": updated.memo,
                                "deadline": updated.deadline,
                                "tag": updated.tag,
                                "priority": updated.priority,
                                "image": updated.image,
                                ],
                             update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func updateCheck(item: TodoModel) {
        do {
            try realm.write {
                item.isDone.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    func updateFlag(item: TodoModel) {
        do {
            try realm.write {
                item.isFlag.toggle()
            }
        } catch {
            print(error)
        }
    }
}

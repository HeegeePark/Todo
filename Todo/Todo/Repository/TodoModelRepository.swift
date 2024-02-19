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

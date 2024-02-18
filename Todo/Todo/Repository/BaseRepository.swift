//
//  BaseRepository.swift
//  Todo
//
//  Created by 박희지 on 2/19/24.
//

import Foundation
import RealmSwift

class BaseRepository<T: Object> {
    typealias Model = T
    private let realm = try! Realm()
    
    func createItem(_ item: Model) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<Model> {
        return realm.objects(Model.self)
    }
    
    func updateItem(id: ObjectId, item: Model) {
    }
    
    func deleteItem(object: ObjectBase) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
}

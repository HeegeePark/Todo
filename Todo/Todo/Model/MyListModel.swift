//
//  MyListModel.swift
//  Todo
//
//  Created by 박희지 on 2/22/24.
//

import Foundation
import RealmSwift

class MyListModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String   // 제목
    @Persisted var regDate: Date   // 등록일
    @Persisted var color: String   // 테마색
    @Persisted var icon: String   // 아이콘
    @Persisted var todos: List<TodoModel>   // TodoModel Realm List
    
    convenience init(title: String, color: String, icon: String) {
        self.init()
        self.title = title
        self.regDate = Date()
        self.color = color
        self.icon = icon
    }
}

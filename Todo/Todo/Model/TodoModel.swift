//
//  TodoModel.swift
//  Todo
//
//  Created by 박희지 on 2/16/24.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String   // 제목
    @Persisted var memo: String? // 한줄메모(옵션)
    @Persisted var deadline: Date? // 마감일
    @Persisted var tag: String? // 태그
    @Persisted var priority: String? // 우선순위
    
    convenience init(title: String, memo: String? = nil, deadline: Date, tag: String? = nil, priority: String? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}

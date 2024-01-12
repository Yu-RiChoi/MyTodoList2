//
//  Todo.swift
//  MyTodoList2
//
//  Created by 최유리 on 1/11/24.
//

import Foundation

struct Todo: Codable {
    let id: Int
    let description: String
    var isDone: Bool
    let category: String
}

extension Todo {
    init(description: String, category: String = "") {
        self.id = UUID().hashValue
        self.description = description
        self.isDone = false
        self.category = category
    }
}

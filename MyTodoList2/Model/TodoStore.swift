//
//  TodoStore.swift
//  MyTodoList2
//
//  Created by 최유리 on 1/11/24.
//

import Foundation

final class TodoStore {
    static var shared: TodoStore = .init()
    
    private let key = "TodoList"
    
    private init() { }
    
    // CRUD
    // Read
    func readAll() -> [Todo] {
        guard let todoListData = UserDefaults.standard.data(forKey: key),
              let todoList = try? JSONDecoder().decode([Todo].self, from: todoListData)
        else {
            return []
        }
        
        return todoList
    }
    
    func readAllAndCategorize() -> [String: [Todo]] {
        let todoList = readAll()
        
        return Dictionary(grouping: todoList) { todo in
            todo.category
        }
    }
    
    // Create
    func create(_ todo: Todo) {
        var todoList = readAll()
        
        todoList.append(todo)
        guard let data = try? JSONEncoder().encode(todoList) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func delete(todoId: Int) {
        var todoList = readAll()
        
        todoList.removeAll { todo in
            todo.id == todoId
        }
        
        // 원하는 Todo가 지워진 상태
        
        guard let data = try? JSONEncoder().encode(todoList) else {
            return
        }
        
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func update(todoId: Int, isDone: Bool? = nil) {
        var todoList = readAll()
        
        guard let targetIndex = todoList.firstIndex(where: { $0.id == todoId })
        else { return }
        
        if let newIsDone = isDone {
            todoList[targetIndex].isDone = newIsDone
        }
        
        // 리스트가 업데이트된 상태
        
        guard let data = try? JSONEncoder().encode(todoList) else { return }
        
        UserDefaults.standard.setValue(data, forKey: key)
    }
}

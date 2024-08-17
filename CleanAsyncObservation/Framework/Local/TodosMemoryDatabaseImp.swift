//
//  TodosMemoryImp.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "Framework Local", category: "Todos Memory Database")

class TodosMemoryDatabaseImp: TodosDatabase {
    var todos: [Todo] = []
    
    func queryTodos() async throws(LocalDataSourceError) -> [Todo] {
        logger.info("Succesfully queried TODOs from memory database: \(self.todos.count)")
        return todos
    }
    
    func updateTodos(with todos: [Todo]) async throws(LocalDataSourceError) {
        logger.info("Succesfully updated memory TODOs: \(todos.count)")
        self.todos = todos
    }
}

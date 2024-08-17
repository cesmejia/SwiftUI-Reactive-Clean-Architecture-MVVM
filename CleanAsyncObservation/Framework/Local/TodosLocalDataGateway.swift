//
//  TodosLocalDataGateway.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

class TodosLocalDataGateway: TodosLocalDataSource {
    let todosDatabase: TodosDatabase
    let todosMemoryDatabase: TodosDatabase

    init(
        todosDatabase: TodosDatabase,
        todosMemoryDatabase: TodosDatabase
    ) {
        self.todosDatabase = todosDatabase
        self.todosMemoryDatabase = todosMemoryDatabase
    }
    
    func queryTodos() async throws(LocalDataSourceError) -> [Todo] {
        let memoryTodos = try await todosMemoryDatabase.queryTodos()
        
        if memoryTodos.isEmpty {
            return try await todosDatabase.queryTodos()
        }
        
        return memoryTodos
    }
}

//
//  TodosRemoteDataGateway.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

class TodosRemoteDataGateway: TodosRemoteDataSource {
    let todosService: TodosService
    let todosDatabase: TodosDatabase
    let todosMemoryDatabase: TodosDatabase
    
    init(
        todosService: TodosService,
        todosDatabase: TodosDatabase,
        todosMemoryDatabase: TodosDatabase
    ) {
        self.todosService = todosService
        self.todosDatabase = todosDatabase
        self.todosMemoryDatabase = todosMemoryDatabase
    }
    
    func fetchTodos() async throws(RemoteDataSourceError) -> [Todo] {
        let todos = try await todosService.fetchTodos()
        try? await todosDatabase.updateTodos(with: todos)
        try? await todosMemoryDatabase.updateTodos(with: todos)
        return todos
    }
}


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
    
    init(todosService: TodosService, todosDatabase: TodosDatabase) {
        self.todosService = todosService
        self.todosDatabase = todosDatabase
    }
    
    func fetchTodos() async throws(RemoteDataSourceError) -> [Todo] {
        let todos = try await todosService.fetchTodos()
        try? await todosDatabase.updateTodos(with: todos)
        return todos
    }
}


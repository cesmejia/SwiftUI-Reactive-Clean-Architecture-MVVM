//
//  TodosLocalDataGateway.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

class TodosLocalDataGateway: TodosLocalDataSource {
    let todosDatabase: TodosDatabase

    init(todosDatabase: TodosDatabase) {
        self.todosDatabase = todosDatabase
    }
    
    func queryTodos() async throws(LocalDataSourceError) -> [Todo] {
        return try await todosDatabase.queryTodos()
    }
}

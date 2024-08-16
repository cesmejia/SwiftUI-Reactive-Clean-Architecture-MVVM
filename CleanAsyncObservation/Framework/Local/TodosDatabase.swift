//
//  TodosDatabase.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

protocol TodosDatabase {
    func queryTodos() async throws(LocalDataSourceError) -> [Todo]
    func updateTodos(with todos: [Todo]) async throws(LocalDataSourceError)
}

class TodosDatabaseStub: TodosDatabase {
    let getTodosResult: Result<[Todo], LocalDataSourceError>
    let updateTodosResult: Result<Void, LocalDataSourceError>
    
    init(
        getTodosResult: Result<[Todo], LocalDataSourceError>,
        updateTodosResult: Result<Void, LocalDataSourceError>
    ) {
        self.getTodosResult = getTodosResult
        self.updateTodosResult = updateTodosResult
    }
    
    func queryTodos() async throws(LocalDataSourceError) -> [Todo] {
        switch getTodosResult {
        case .success(let todos):
            return todos
        case .failure(let error):
            throw error
        }
    }
    
    func updateTodos(with todos: [Todo]) async throws(LocalDataSourceError) {
        switch updateTodosResult {
        case .success:
            break
        case .failure(let error):
            throw error
        }
    }
}

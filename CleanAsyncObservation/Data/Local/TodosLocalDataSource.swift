//
//  TodosLocalDataSource.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

protocol TodosLocalDataSource {
    func queryTodos() async throws(LocalDataSourceError) -> [Todo]
}

class TodosLocalDataSourceStub: TodosLocalDataSource {
    let result: Result<[Todo], LocalDataSourceError>
    
    init(result: Result<[Todo], LocalDataSourceError>) {
        self.result = result
    }
    
    func queryTodos() async throws(LocalDataSourceError) -> [Todo] {
        switch result {
        case .success(let todos):
            return todos
        case .failure(let error):
            throw error
        }
    }
}

enum LocalDataSourceError: Error {
    case unknown
}

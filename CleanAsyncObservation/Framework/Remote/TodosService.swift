//
//  TodosService.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

protocol TodosService {
    func fetchTodos() async throws(RemoteDataSourceError) -> [Todo]
}

class TodosServiceStub: TodosService {
    let result: Result<[Todo], RemoteDataSourceError>
    
    init(result: Result<[Todo], RemoteDataSourceError>) {
        self.result = result
    }
    
    func fetchTodos() async throws(RemoteDataSourceError) -> [Todo] {
        switch result {
        case .success(let todos):
            return todos
        case .failure(let error):
            throw error
        }
    }
}

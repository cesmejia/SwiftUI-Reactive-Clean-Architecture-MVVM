//
//  TodosRemoteDataSource.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 03/08/24.
//

import Foundation

protocol TodosRemoteDataSource {
    func fetchTodos() async throws(RemoteDataSourceError) -> [Todo]
}

class TodosRemoteDataSourceStub: TodosRemoteDataSource {
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

enum RemoteDataSourceError: Error {
    case networkError
    case decodingError
    case unknownError
    case noData
    case serverError
    case unauthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case timeout
    case invalidResponse
    case not200Response
}

//
//  TodosDataSource.swift
//  CleanObservation
//
//  Created by Ces Mejia on 14/08/24.
//

import Foundation
import Combine

protocol TodosDataSource {
    var todos: CurrentValueSubject<[Todo], Never> { get }
    func getTodos() async throws
    func refreshTodos() async throws
}

class TodosDataSourceStub: TodosDataSource {
    let todos = CurrentValueSubject<[Todo], Never>([])
    
    private let result: Result<[Todo], Error>
    
    init(result: Result<[Todo], Error>) {
        self.result = result
    }
    
    func getTodos() async throws {
        try await manageResult()
    }
    
    func refreshTodos() async throws {
        try await manageResult()
    }
    
    private func manageResult() async throws {
        switch result {
        case .success(let todos):
            self.todos.send(todos)
        case .failure(let error):
            throw error
        }
    }
}

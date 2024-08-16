//
//  GetTodosUseCase.swift
//  CleanObservation
//
//  Created by Ces Mejia on 14/08/24.
//

import Foundation
import Combine

@preconcurrency
class GetTodosUseCase {
    private let todosDataSource: TodosDataSource
    let todos = CurrentValueSubject<[Todo], Never>([])
    
    private var cancellables = Set<AnyCancellable>()
    
    init(todosDataSource: TodosDataSource) {
        self.todosDataSource = todosDataSource
        
        todosDataSource.todos
            .dropFirst()
            .sink(receiveValue: { [unowned self] todos in
                self.todos.send(todos)
            }).store(in: &cancellables)
    }
    
    func getTodos() async throws {
        try await todosDataSource.getTodos()
    }
    
    func refreshTodos() async throws {
        try await todosDataSource.refreshTodos()
    }
}

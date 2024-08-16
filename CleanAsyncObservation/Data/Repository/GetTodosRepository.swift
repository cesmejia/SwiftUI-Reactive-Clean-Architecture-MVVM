//
//  GetTodosRepository.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 03/08/24.
//

import OSLog
import Combine

private let logger = Logger(subsystem: "Data Repository", category: "Todos Repository")

class GetTodosRepository: TodosDataSource {
    let todosRemoteDataSource: TodosRemoteDataSource
    let todosLocalDataSource: TodosLocalDataSource
    
    var todos = CurrentValueSubject<[Todo], Never>([])

    init(todosRemoteDataSource: TodosRemoteDataSource, todosLocalDataSource: TodosLocalDataSource) {
        self.todosRemoteDataSource = todosRemoteDataSource
        self.todosLocalDataSource = todosLocalDataSource
    }
    
    func refreshTodos() async throws {
        let remoteTodos = try await todosRemoteDataSource.fetchTodos()
        todos.send(remoteTodos)
    }
    
    func getTodos() async throws {
        do {
            let localTodos = try await todosLocalDataSource.queryTodos()
            if localTodos.isEmpty {
                logger.info("No local todos found, refreshing...")
                do {
                    try await refreshTodos()
                } catch {
                    throw error
                }
            } else {
                todos.send(localTodos)
            }
        } catch {
            try await refreshTodos()
        }
    }
}

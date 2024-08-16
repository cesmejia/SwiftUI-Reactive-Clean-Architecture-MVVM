//
//  TodosDatabaseImpTests.swift
//  CleanAsyncObservationTests
//
//  Created by Ces Mejia on 16/08/24.
//

import Testing
import Foundation
@testable import CleanAsyncObservation

final class TodosDatabaseImpTests {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    static let todo2 = Todo(userId: 2, id: 2, title: "title", completed: true)
    
    static let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    static let url = URL(string: Constants.TODO.baseURL + Constants.TODO.todosEndpoint)!
    
    deinit {
        try! FileManager.default.removeItem(at: Self.temporaryDirectoryURL)
    }

    @Test func whenRequestingQueryingTodosInitially_getsAnEmptyTodoList() async throws {
        let sut = makeSUT()
        let todos = try await sut.queryTodos()
        #expect(todos.isEmpty)
    }
    
    @Test func whenUpdatingTodos_todosAreSavedInADirectory() async throws {
        let todoList = [Self.todo, Self.todo2]
        let sut = makeSUT()
        _ = try await sut.updateTodos(with: todoList)
        let todos = try await sut.queryTodos()
        #expect(todos == todoList)
    }
    
    private func makeSUT() -> TodosDatabaseImp {
        return TodosDatabaseImp(directoryURL: Self.temporaryDirectoryURL)
    }

}


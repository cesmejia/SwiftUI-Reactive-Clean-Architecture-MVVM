//
//  GetTodosUseCaseTests.swift
//  CleanObservationTests
//
//  Created by Ces Mejia on 14/08/24.
//

import Testing
import Foundation
@testable import CleanAsyncObservation

struct GetTodosUseCaseTests {
    
    static let todo = Todo(userId: 1, id: 1, title: "Hello", completed: false)

    @Test func whenGettingTodosIsSuccessful_todosAreUpdated() async throws {
        let sut = makeSUT(result: .success([Self.todo]))
        try await sut.getTodos()
        #expect(sut.todos.value == [Self.todo])
    }
    
    @Test func whenGettingTodosIsNotSuccessful_getTodosThrowsAnError() async throws {
        let passedError = NSError(domain: "", code: 0)
        let sut = makeSUT(result: .failure(passedError))
        do {
            try await sut.getTodos()
            #expect(Bool(false))
        } catch {
            #expect(error as NSError == passedError)
        }
    }
    
    @Test func whenRefreshingTodosIsSuccessful_todosAreUpdated() async throws {
        let sut = makeSUT(result: .success([Self.todo]))
        try await sut.refreshTodos()
        #expect(sut.todos.value == [Self.todo])
    }
    
    @Test func whenRefreshingTodosIsNotSuccessful_refreshTodosThrowsAnError() async {
        let passedError = NSError(domain: "", code: 0)
        let sut = makeSUT(result: .failure(passedError))
        do {
            try await sut.refreshTodos()
            #expect(Bool(false))
        } catch {
            #expect(error as NSError == passedError)
        }
    }
    
    private func makeSUT(result: Result<[Todo], Error>) -> GetTodosUseCase {
        let todosDataSource = TodosDataSourceStub(result: result)
        return GetTodosUseCase(todosDataSource: todosDataSource)
    }

}

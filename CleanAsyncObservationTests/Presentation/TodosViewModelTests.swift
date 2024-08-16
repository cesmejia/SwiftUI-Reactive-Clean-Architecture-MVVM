//
//  TodosViewModelTests.swift
//  CleanObservationTests
//
//  Created by Ces Mejia on 14/08/24.
//

import Testing
import Foundation
@testable import CleanAsyncObservation

@MainActor
struct TodosViewModelTests {
    
    nonisolated static let todo = Todo(userId: 1, id: 1, title: "Hello", completed: false)

    @Test func whenGettingTodosIsSuccessful_todosAreUpdated() async {
        let sut = makeSUT()
        await sut.getTodos()
        #expect(sut.todos == [Self.todo])
    }
    
    @Test func whenGettingTodosIsNotSuccessful_updatesErrorText() async throws {
        let passedError = NSError(domain: "", code: 0)
        let sut = makeSUT(result: .failure(passedError))
        await sut.getTodos()
        #expect(sut.errorText == passedError.localizedDescription)
    }
    
    @Test func whenRefreshingTodosIsSuccessful_todosAreUpdated() async throws {
        let sut = makeSUT()
        await sut.refreshTodos()
        #expect(sut.todos == [Self.todo])
    }
    
    @Test func whenRefreshingTodosIsNotSuccessful_updatesErrorText() async {
        let passedError = NSError(domain: "", code: 0)
        let sut = makeSUT(result: .failure(passedError))
        await sut.refreshTodos()
        #expect(sut.errorText == passedError.localizedDescription)
    }
    
    @Test func whenCallingTodoRowTapped_delegateIsCalled() async {
        let delegate = TodosViewActionsSpy()
        let sut = makeSUT(delegate: delegate)
        sut.todoRowTapped(for: Self.todo)
        #expect(delegate.todoRowTappedCalled == true)
    }
    
    private func makeSUT(result: Result<[Todo], Error> = .success([Self.todo]), delegate: TodosViewActionsSpy? = nil) -> TodosViewModel {
        let todosDataSource = TodosDataSourceStub(result: result)
        let getTodosUseCase = GetTodosUseCase(todosDataSource: todosDataSource)
        return TodosViewModel(getTodosUseCase: getTodosUseCase, delegate: delegate)
    }
    
    class TodosViewActionsSpy: TodosViewActions {
        var todoRowTappedCalled = false
        
        func todoRowTapped(for todo: Todo) {
            todoRowTappedCalled = true
        }
    }

}

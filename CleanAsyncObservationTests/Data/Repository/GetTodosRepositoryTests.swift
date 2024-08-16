//
//  GetTodosRepositoryTests.swift
//  CleanAsyncObservationTests
//
//  Created by Ces Mejia on 16/08/24.
//

import Testing
@testable import CleanAsyncObservation

struct GetTodosRepositoryTests {
    
    static let localTodo: Todo = .init(userId: 1, id: 1, title: "Todo 1", completed: false)
    static let remoteTodo: Todo = .init(userId: 2, id: 2, title: "Todo 2", completed: false)

    @Test func testGetTodosWithLocalSuccessfulResponse_todosValueIsUpdatedWithLocalTodos() async throws {
        let sut = makeSUT()
        try await sut.getTodos()
        #expect(sut.todos.value == [Self.localTodo])
    }
    
    @Test func testGetTodosWithLocalEmptySuccessfulResponse_todosValueIsUpdatedWithRemoteTodos() async throws {
        let sut = makeSUT(localResult: .success([]))
        try await sut.getTodos()
        #expect(sut.todos.value == [Self.remoteTodo])
    }
    
    @Test func testGetTodosWithLocalFailureResponse_todosValueIsUpdatedWithRemoteTodos() async throws {
        let sut = makeSUT(localResult: .failure(.unknown))
        try await sut.getTodos()
        #expect(sut.todos.value == [Self.remoteTodo])
    }
    
    @Test func testGetTodosWithLocalAndRemoteFailureResponse_throwsError() async {
        let networkError = RemoteDataSourceError.networkError
        let sut = makeSUT(localResult: .failure(.unknown), remoteResult: .failure(networkError))
        do {
            try await sut.getTodos()
            #expect(Bool(false))
        } catch {
            #expect(error as? RemoteDataSourceError == networkError)
        }
    }
    
    @Test func testRefreshTodosWithLocalSuccessfulResponse_todosValueIsUpdatedWithLocalTodos() async throws {
        let sut = makeSUT()
        try await sut.refreshTodos()
        #expect(sut.todos.value == [Self.remoteTodo])
    }
    
    private func makeSUT(
        localResult: Result<[Todo], LocalDataSourceError> = .success([Self.localTodo]),
        remoteResult: Result<[Todo], RemoteDataSourceError> = .success([Self.remoteTodo])
    ) -> GetTodosRepository {
        let localDataSource = TodosLocalDataSourceStub(result: localResult)
        let remoteDataSource = TodosRemoteDataSourceStub(result: remoteResult)
        return GetTodosRepository(
            todosRemoteDataSource: remoteDataSource,
            todosLocalDataSource: localDataSource
        )
    }
}

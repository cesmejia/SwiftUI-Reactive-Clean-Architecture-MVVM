//
//  TodosServiceTests.swift
//  CleanAsyncObservationTests
//
//  Created by Ces Mejia on 04/08/24.
//

import Testing
import Foundation
@testable import CleanAsyncObservation

final class TodosServiceTests {
    
    static let todo = Todo(userId: 1, id: 1, title: "Todo 1", completed: false)
    static let todo2 = Todo(userId: 2, id: 2, title: "Todo 2", completed: true)
    
    static let url = URL(string: Constants.TODO.baseURL + Constants.TODO.todosEndpoint)!
    
    deinit {
        URLProtocolStub.removeStub()
    }

    @Test func whenFetchingTodosIsSuccessful_getsTodos() async throws {
        let todoList = [Self.todo, Self.todo2]
        let encodedTodoList = try? JSONEncoder().encode(todoList.self)
        let urlResponse = HTTPURLResponse(url: Self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        URLProtocolStub.stub(data: encodedTodoList, response: urlResponse, error: nil)

        let sut = makeSUT()
        let todos = try await sut.fetchTodos()
        #expect(todos == [Self.todo, Self.todo2])
    }
    
    @Test func whenFetchingTodosResponseStatusIsNot200_throwsNot200ResponseError() async {
        let todoList = [Self.todo, Self.todo2]
        let encodedTodoList = try? JSONEncoder().encode(todoList.self)
        let urlResponse = HTTPURLResponse(url: Self.url, statusCode: 500, httpVersion: nil, headerFields: nil)!
        URLProtocolStub.stub(data: encodedTodoList, response: urlResponse, error: nil)

        let sut = makeSUT()
        do {
            let _ = try await sut.fetchTodos()
            #expect(Bool(false))
        } catch {
            #expect(error == .not200Response)
        }
    }
    
    @Test func whenFetchingTodosResponseCannotBeDecoded_throwsDecodingError() async {
        let encodedTodoListFaulty = Data("Other Data".utf8)
        let urlResponse = HTTPURLResponse(url: Self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        URLProtocolStub.stub(data: encodedTodoListFaulty, response: urlResponse, error: nil)

        let sut = makeSUT()
        do {
            let _ = try await sut.fetchTodos()
            #expect(Bool(false))
        } catch {
            #expect(error == .decodingError)
        }
    }
    
    private func makeSUT() -> TodosServiceImp {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let urlSession = URLSession(configuration: configuration)
        
        let todosService = TodosServiceImp(urlSession: urlSession)
        return todosService
    }

}

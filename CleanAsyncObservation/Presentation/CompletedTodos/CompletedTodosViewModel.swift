//
//  CompletedTodosViewModel.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation
import Combine

@MainActor
@Observable class CompletedTodosViewModel {
    private let getTodosUseCase: GetTodosUseCase
    weak var delegate: CompletedTodosViewActions?
    
    let title = "Completed"
    var todos = [Todo]()
    var errorText: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getTodosUseCase: GetTodosUseCase,
        delegate: CompletedTodosViewActions?
    ) {
        self.getTodosUseCase = getTodosUseCase
        self.delegate = delegate
        
        getTodosUseCase.todos
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] todos in
                self.todos = todos.filter(\.completed)
            }).store(in: &cancellables)
    }
    
    func getTodos() async {
        do {
            try await getTodosUseCase.getTodos()
        } catch {
            errorText = error.localizedDescription
        }
    }
    
    func refreshTodos() async {
        do {
            try await getTodosUseCase.refreshTodos()
        } catch {
            errorText = error.localizedDescription
        }
    }
    
    func todoRowTapped(for todo: Todo) {
        delegate?.todoRowTapped(for: todo)
    }
}

@MainActor
protocol CompletedTodosViewActions: AnyObject {
    func todoRowTapped(for todo: Todo)
}


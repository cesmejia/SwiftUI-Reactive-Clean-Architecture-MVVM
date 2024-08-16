//
//  TodosViewModel.swift
//  CleanObservation
//
//  Created by Ces Mejia on 14/08/24.
//

import Foundation
import Combine

@MainActor
@Observable class TodosViewModel {
    private let getTodosUseCase: GetTodosUseCase
    weak var delegate: TodosViewActions?
    
    var todos = [Todo]()
    var errorText: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getTodosUseCase: GetTodosUseCase,
        delegate: TodosViewActions?
    ) {
        self.getTodosUseCase = getTodosUseCase
        self.delegate = delegate
        
        getTodosUseCase.todos
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] todos in
                self.todos = todos
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
protocol TodosViewActions: AnyObject {
    func todoRowTapped(for todo: Todo)
}

//
//  TodosView.swift
//  CleanObservation
//
//  Created by Ces Mejia on 14/08/24.
//

import SwiftUI

struct TodosView: View {
    let viewModel: TodosViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.todos) { todo in
                Button {
                    viewModel.todoRowTapped(for: todo)
                } label: {
                    HStack {
                        Text(todo.title)
                        Spacer()
                        Text(todo.completed ? "✅" : "❌")
                    }
                }
                .buttonStyle(.plain)
                
            }
        }
        .navigationTitle("Todos")
        .task {
            await viewModel.getTodos()
        }
    }
}

#Preview {
    let todo = Todo(userId: 1, id: 1, title: "Hello", completed: false)
    let todosDataSource = TodosDataSourceStub(result: .success([todo]))
    let getTodosUseCase = GetTodosUseCase(todosDataSource: todosDataSource)
    let todosViewModel = TodosViewModel(getTodosUseCase: getTodosUseCase, delegate: nil)
    NavigationView {
        TodosView(viewModel: todosViewModel)
    }
}

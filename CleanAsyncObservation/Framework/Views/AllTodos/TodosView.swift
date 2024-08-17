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
        .navigationTitle(viewModel.title)
        .onViewDidLoadTask {
            await viewModel.getTodos()
        }
        .toolbar {
            ToolbarItem {
                Button(viewModel.toolbarButtonText) {
                    Task {
                        await viewModel.refreshTodos()
                    }
                }
            }
        }
    }
}

#Preview {
    let factory = HomeFactoryImp()
    let todo = Todo(userId: 1, id: 1, title: "Hello", completed: false)
    let todosDataSource = TodosDataSourceStub(result: .success([todo]))
    let view = factory.makeTodosView(getTodosSource: todosDataSource, delegate: nil)
    return NavigationView {
        view
    }
}

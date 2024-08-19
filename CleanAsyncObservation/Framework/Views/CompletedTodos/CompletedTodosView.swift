//
//  CompletedTodosView.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import SwiftUI

struct CompletedTodosView: View {
    let viewModel: CompletedTodosViewModel
    
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
    }
}

#Preview {
    let factory = CompletedTodosFactoryImp()
    let todo1 = Todo(userId: 1, id: 1, title: "Hello", completed: false)
    let todo2 = Todo(userId: 2, id: 2, title: "Hello", completed: true)
    let todosDataSource = TodosDataSourceStub(result: .success([todo1, todo2]))
    let view = factory.makeCompletedTodosView(getTodosSource: todosDataSource, delegate: nil)
    return NavigationView {
        view
    }
}

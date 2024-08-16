//
//  TodoDetailsView.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import SwiftUI

struct TodoDetailsView: View {
    let viewModel: TodoDetailsViewModel
    
    var body: some View {
        List {
            Section("Title") {
                Text(viewModel.todo.title)
            }
            
            Section("User Id") {
                Text(viewModel.todo.userId.description)
            }
            
            Section("Id") {
                Text(viewModel.todo.id.description)
            }
            
            Section("Completed") {
                Text(viewModel.todo.completed ? "Completed" : "Not Completed")
            }
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    let factory = HomeFactoryImp()
    let todo = Todo(userId: 1, id: 1, title: "Hello", completed: false)
    let view = factory.makeTodoDetailsView(with: todo)
    return NavigationView {
        view
    }
}

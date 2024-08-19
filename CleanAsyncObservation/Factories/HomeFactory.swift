//
//  HomeFactory.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import SwiftUI

@MainActor
protocol HomeFactory {
    func makeModule(getTodosSource: TodosDataSource, delegate: TodosViewActions?) -> UIViewController
    func makeTodoDetails(with todo: Todo) -> UIViewController
}

struct HomeFactoryImp: HomeFactory {
    func makeModule(getTodosSource: TodosDataSource, delegate: TodosViewActions?) -> UIViewController {
        let view = makeTodosView(getTodosSource: getTodosSource, delegate: delegate)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Todos"
        viewController.tabBarItem.image = UIImage(systemName: "checklist")
        return viewController
    }
    
    func makeTodosView(getTodosSource: TodosDataSource, delegate: TodosViewActions?) -> TodosView {
        let getTodosUseCase = GetTodosUseCase(todosDataSource: getTodosSource)
        let todosViewModel = TodosViewModel(getTodosUseCase: getTodosUseCase, delegate: delegate)
        let view = TodosView(viewModel: todosViewModel)
        return view
    }
    
    func makeTodoDetails(with todo: Todo) -> UIViewController {
        let view = makeTodoDetailsView(with: todo)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
    
    func makeTodoDetailsView(with todo: Todo) -> TodoDetailsView {
        let detailsViewModel = TodoDetailsViewModel(todo: todo)
        let view = TodoDetailsView(viewModel: detailsViewModel)
        return view
    }
}

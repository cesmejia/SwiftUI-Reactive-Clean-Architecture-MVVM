//
//  HomeFactory.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import SwiftUI

@MainActor
protocol HomeFactory {
    func makeModule() -> UIViewController
    func makeTodoDetails(with todo: Todo) -> UIViewController
}

struct HomeFactoryImp: HomeFactory {
    func makeModule() -> UIViewController {
        let todosService = TodosServiceImp()
        let todosDatabase = TodosDatabaseImp()
        let todosDataSourceRemote = TodosRemoteDataGateway(todosService: todosService, todosDatabase: todosDatabase)
        let todosDataSourceLocal = TodosLocalDataGateway(todosDatabase: todosDatabase)
        let getTodosSource = GetTodosRepository(todosRemoteDataSource: todosDataSourceRemote, todosLocalDataSource: todosDataSourceLocal)
        let view = makeTodosView(getTodosSource: getTodosSource, delegate: nil)
        let viewController = UIHostingController(rootView: view)
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

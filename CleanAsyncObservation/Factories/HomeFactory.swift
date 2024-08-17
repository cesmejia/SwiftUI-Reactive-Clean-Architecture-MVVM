//
//  HomeFactory.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import SwiftUI

@MainActor
protocol HomeFactory {
    func makeModule(delegate: TodosViewActions?) -> UIViewController
    func makeTodoDetails(with todo: Todo) -> UIViewController
}

struct HomeFactoryImp: HomeFactory {
    func makeModule(delegate: TodosViewActions?) -> UIViewController {
        let todosService = TodosServiceImp()
        let todosDatabase = TodosDatabaseImp()
        let todosMemoryDatabase = TodosMemoryDatabaseImp()
        let todosDataSourceRemote = TodosRemoteDataGateway(
            todosService: todosService,
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let todosDataSourceLocal = TodosLocalDataGateway(
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let getTodosSource = GetTodosRepository(todosRemoteDataSource: todosDataSourceRemote, todosLocalDataSource: todosDataSourceLocal)
        let view = makeTodosView(getTodosSource: getTodosSource, delegate: delegate)
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
    
    func makeCompletedTodosView(getTodosSource: TodosDataSource, delegate: CompletedTodosViewActions?) -> CompletedTodosView {
        let getTodosUseCase = GetTodosUseCase(todosDataSource: getTodosSource)
        let completedTodosViewModel = CompletedTodosViewModel(getTodosUseCase: getTodosUseCase, delegate: delegate)
        let view = CompletedTodosView(viewModel: completedTodosViewModel)
        return view
    }
}

@MainActor
protocol HomeTabFactory {
    func makeModule(delegate: TodosViewActions?) -> UIViewController
    func makeTodoDetails(with todo: Todo) -> UIViewController
}

struct HomeTabFactoryImp: HomeTabFactory {
    func makeModule(delegate: TodosViewActions?) -> UIViewController {
        let todosService = TodosServiceImp()
        let todosDatabase = TodosDatabaseImp()
        let todosMemoryDatabase = TodosMemoryDatabaseImp()
        let todosDataSourceRemote = TodosRemoteDataGateway(
            todosService: todosService,
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let todosDataSourceLocal = TodosLocalDataGateway(
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let getTodosSource = GetTodosRepository(todosRemoteDataSource: todosDataSourceRemote, todosLocalDataSource: todosDataSourceLocal)
        let view = makeTodosView(getTodosSource: getTodosSource, delegate: delegate)
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
    
    func makeCompletedTodosView(getTodosSource: TodosDataSource, delegate: CompletedTodosViewActions?) -> CompletedTodosView {
        let getTodosUseCase = GetTodosUseCase(todosDataSource: getTodosSource)
        let completedTodosViewModel = CompletedTodosViewModel(getTodosUseCase: getTodosUseCase, delegate: delegate)
        let view = CompletedTodosView(viewModel: completedTodosViewModel)
        return view
    }
}

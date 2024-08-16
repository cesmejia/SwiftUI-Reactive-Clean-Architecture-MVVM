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
        let getTodosUseCase = GetTodosUseCase(todosDataSource: getTodosSource)
        let todosViewModel = TodosViewModel(getTodosUseCase: getTodosUseCase, delegate: nil)
        let viewController = UIHostingController(rootView: TodosView(viewModel: todosViewModel))
        return viewController
    }
    
    func makeTodoDetails(with todo: Todo) -> UIViewController {
//        let detailsViewModel = TodoDetailsViewModel(todo: todo)
//        let viewController = TodoDetailsViewController(viewModel: detailsViewModel)
//        return viewController
        UIViewController()
    }
}

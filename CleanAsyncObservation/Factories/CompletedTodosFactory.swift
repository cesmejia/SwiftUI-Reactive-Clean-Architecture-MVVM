//
//  CompletedTodosFactory.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 18/08/24.
//

import SwiftUI

@MainActor
protocol CompletedTodosFactory {
    func makeModule(delegate: CompletedTodosViewActions?) -> UIViewController
}

struct CompletedTodosFactoryImp: CompletedTodosFactory {
    func makeModule(delegate: CompletedTodosViewActions?) -> UIViewController {
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
        let view = makeCompletedTodosView(getTodosSource: getTodosSource, delegate: delegate)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
    
    func makeCompletedTodosView(getTodosSource: TodosDataSource, delegate: CompletedTodosViewActions?) -> CompletedTodosView {
        let getTodosUseCase = GetTodosUseCase(todosDataSource: getTodosSource)
        let completedTodosViewModel = CompletedTodosViewModel(getTodosUseCase: getTodosUseCase, delegate: delegate)
        let view = CompletedTodosView(viewModel: completedTodosViewModel)
        return view
    }
}

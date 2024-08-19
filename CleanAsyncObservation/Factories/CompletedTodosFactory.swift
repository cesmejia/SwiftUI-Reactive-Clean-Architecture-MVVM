//
//  CompletedTodosFactory.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 18/08/24.
//

import SwiftUI

@MainActor
protocol CompletedTodosFactory {
    func makeModule(getTodosSource: TodosDataSource, delegate: CompletedTodosViewActions?) -> UIViewController
}

struct CompletedTodosFactoryImp: CompletedTodosFactory {
    func makeModule(getTodosSource: TodosDataSource, delegate: CompletedTodosViewActions?) -> UIViewController {
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

//
//  CompletedTodosFactory.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 18/08/24.
//

import SwiftUI

@MainActor
protocol CompletedTodosFactory {
    func makeModule(getTodosUseCase: GetTodosUseCase, delegate: CompletedTodosViewActions?) -> UIViewController
}

struct CompletedTodosFactoryImp: CompletedTodosFactory {
    func makeModule(getTodosUseCase: GetTodosUseCase, delegate: CompletedTodosViewActions?) -> UIViewController {
        let view = makeCompletedTodosView(getTodosUseCase: getTodosUseCase, delegate: delegate)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Completed Todos"
        viewController.tabBarItem.image = UIImage(systemName: "checklist.checked")
        return viewController
    }
    
    func makeCompletedTodosView(getTodosUseCase: GetTodosUseCase, delegate: CompletedTodosViewActions?) -> CompletedTodosView {
        let completedTodosViewModel = CompletedTodosViewModel(getTodosUseCase: getTodosUseCase, delegate: delegate)
        let view = CompletedTodosView(viewModel: completedTodosViewModel)
        return view
    }
}

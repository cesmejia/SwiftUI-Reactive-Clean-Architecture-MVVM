//
//  CompletedTodosCoordinator.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 18/08/24.
//

import UIKit

final class CompletedTodosCoordinator: Coordinator {
    let navigation: UINavigationController
    private let completedTodosFactory: CompletedTodosFactory
    private let todosDataSource: TodosDataSource
    
    init(
        navigation: UINavigationController,
        completedTodosFactory: CompletedTodosFactory,
        todosDataSource: TodosDataSource
    ) {
        self.navigation = navigation
        self.completedTodosFactory = completedTodosFactory
        self.todosDataSource = todosDataSource
    }
    
    func start() {
        let controller = completedTodosFactory.makeModule(getTodosSource: todosDataSource, delegate: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: false)
    }
}

extension CompletedTodosCoordinator: CompletedTodosViewActions {
    func todoRowTapped(for todo: Todo) {
        // Add Navigation
    }
}


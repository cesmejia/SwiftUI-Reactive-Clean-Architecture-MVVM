//
//  CompletedTodosCoordinator.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 18/08/24.
//

import UIKit

final class CompletedTodosCoordinator: Coordinator {
    let navigation: UINavigationController
    let tabNavigation: UITabBarController
    private let completedTodosFactory: CompletedTodosFactory
    private let todosDataSource: TodosDataSource
    
    init(
        navigation: UINavigationController,
        tabNavigation: UITabBarController,
        completedTodosFactory: CompletedTodosFactory,
        todosDataSource: TodosDataSource
    ) {
        self.navigation = navigation
        self.tabNavigation = tabNavigation
        self.completedTodosFactory = completedTodosFactory
        self.todosDataSource = todosDataSource
    }
    
    func start() {
        let controller = completedTodosFactory.makeModule(getTodosSource: todosDataSource, delegate: self)
        controller.tabBarItem.title = "Completed Todos"
        tabNavigation.viewControllers?.append(controller)
    }
}

extension CompletedTodosCoordinator: CompletedTodosViewActions {
    func todoRowTapped(for todo: Todo) {
        // Add Navigation
    }
}


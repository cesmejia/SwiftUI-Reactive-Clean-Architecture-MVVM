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
    
    init(
        navigation: UINavigationController,
        tabNavigation: UITabBarController,
        completedTodosFactory: CompletedTodosFactory
    ) {
        self.navigation = navigation
        self.tabNavigation = tabNavigation
        self.completedTodosFactory = completedTodosFactory
    }
    
    func start() {
        let controller = completedTodosFactory.makeModule(delegate: self)
        controller.tabBarItem.title = "Completed Todos"
        tabNavigation.viewControllers = [controller]
    }
}

extension CompletedTodosCoordinator: CompletedTodosViewActions {
    func todoRowTapped(for todo: Todo) {
        // Add Navigation
    }
}


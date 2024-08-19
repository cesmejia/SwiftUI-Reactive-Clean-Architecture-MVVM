//
//  HomeCoordinator.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    let navigation: UINavigationController
    private let homeFactory: HomeFactory
    private let getTodosSource: TodosDataSource
    
    init(
        navigation: UINavigationController,
        homeFactory: HomeFactory,
        getTodosSource: TodosDataSource
    ) {
        self.navigation = navigation
        self.homeFactory = homeFactory
        self.getTodosSource = getTodosSource
    }
    
    func start() {
        let controller = homeFactory.makeModule(getTodosSource: getTodosSource, delegate: self)
        controller.tabBarItem.title = "Todos"
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
    
    private func navigateToDetail(for todo: Todo) {
        let controller = homeFactory.makeTodoDetails(with: todo)
        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: TodosViewActions {
    func todoRowTapped(for todo: Todo) {
        navigateToDetail(for: todo)
    }
}

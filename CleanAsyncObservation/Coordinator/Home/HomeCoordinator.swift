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
    private let getTodosUseCase: GetTodosUseCase
    
    init(
        navigation: UINavigationController,
        homeFactory: HomeFactory,
        getTodosUseCase: GetTodosUseCase
    ) {
        self.navigation = navigation
        self.homeFactory = homeFactory
        self.getTodosUseCase = getTodosUseCase
    }
    
    func start() {
        let controller = homeFactory.makeModule(getTodosUseCase: getTodosUseCase, delegate: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: false)
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

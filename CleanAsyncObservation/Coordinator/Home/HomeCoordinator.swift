//
//  HomeCoordinator.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    private let homeFactory: HomeFactory
    
    init(navigation: UINavigationController, homeFactory: HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }
    
    func start() {
        let controller = homeFactory.makeModule(delegate: self)
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

final class HomeTabCoordinator: TabCoordinator {
    var navigation: UITabBarController
    private let homeFactory: HomeTabFactory
    
    init(navigation: UITabBarController, homeFactory: HomeTabFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }
    
    func start() {
        let controller = homeFactory.makeModule(delegate: self)
//        navigation.navigationBar.prefersLargeTitles = true
//        navigation.pushViewController(controller, animated: true)
        controller.tabBarItem.title = "Home"
        navigation.viewControllers = [controller]
    }
    
    private func navigateToDetail(for todo: Todo) {
        let controller = homeFactory.makeTodoDetails(with: todo)
//        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeTabCoordinator: TodosViewActions {
    func todoRowTapped(for todo: Todo) {
        navigateToDetail(for: todo)
    }
}

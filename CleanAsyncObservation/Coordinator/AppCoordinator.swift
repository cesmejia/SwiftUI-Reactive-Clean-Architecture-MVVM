//
//  AppCoordinator.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

final class AppTabCoordinator: TabCoordinator {
    var tabNavigation: UITabBarController
    private let appFactory: AppFactory
    var childCoordinators = [Coordinator]()
    var childNavigationControllers = [UINavigationController]()
    var todosDataSource: TodosDataSource!
    
    init(navigation: UITabBarController, appFactory: AppFactory, window: UIWindow?) {
        self.tabNavigation = navigation
        self.appFactory = appFactory
        configWindow(window: window)
    }
    
    func start() {
        todosDataSource = appFactory.makeTodosDataSource()
        
        let homeNavigationController = UINavigationController()
        childNavigationControllers.append(homeNavigationController)
        
        let coordinator = appFactory.makeHomeCoordinator(
            navigation: homeNavigationController,
            tabNavigation: tabNavigation,
            todosDataSource: todosDataSource
        )
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
    
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = tabNavigation
        window?.makeKeyAndVisible()
    }
}

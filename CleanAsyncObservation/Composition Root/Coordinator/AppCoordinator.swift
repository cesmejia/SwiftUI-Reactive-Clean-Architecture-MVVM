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
    var getTodosUseCase: GetTodosUseCase!
    
    init(navigation: UITabBarController, appFactory: AppFactory, window: UIWindow?) {
        self.tabNavigation = navigation
        self.appFactory = appFactory
        configWindow(window: window)
    }
    
    func start() {
        getTodosUseCase = appFactory.makeTodosUseCase()
        
        let homeNavigationController = UINavigationController()
        childNavigationControllers.append(homeNavigationController)
        
        let coordinator = appFactory.makeHomeCoordinator(
            navigation: homeNavigationController,
            getTodosUseCase: getTodosUseCase
        )
        childCoordinators.append(coordinator)
        coordinator.start()
        
        let completedTodosNavigationController = UINavigationController()
        childNavigationControllers.append(completedTodosNavigationController)
        
        let completedTodosCoordinator = appFactory.makeCompletedTodosCoordinator(
            navigation: completedTodosNavigationController,
            getTodosUseCase: getTodosUseCase
        )
        childCoordinators.append(completedTodosCoordinator)
        completedTodosCoordinator.start()
        
        tabNavigation.setViewControllers(childNavigationControllers, animated: false)
    }
    
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = tabNavigation
        window?.makeKeyAndVisible()
    }
}

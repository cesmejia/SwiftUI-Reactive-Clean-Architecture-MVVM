//
//  AppCoordinator.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    private let appFactory: AppFactory
    var childCoordinators: [Coordinator] = []
    
    init(navigation: UINavigationController, appFactory: AppFactory, window: UIWindow?) {
        self.navigation = navigation
        self.appFactory = appFactory
        configWindow(window: window)
    }
    
    func start() {
        let coordinator = appFactory.makeHomeCoordinator(navigation: navigation)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

final class AppTabCoordinator: TabCoordinator {
    var navigation: UITabBarController
    private let appTabFactory: AppTabFactory
    var childCoordinators: [TabCoordinator] = []
    
    init(navigation: UITabBarController, appTabFactory: AppTabFactory, window: UIWindow?) {
        self.navigation = navigation
        self.appTabFactory = appTabFactory
        configWindow(window: window)
    }
    
    func start() {
        let coordinator = appTabFactory.makeHomeTabCoordinator(navigation: navigation)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

//
//  AppFactory.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

@MainActor
protocol AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController, tabNavigation: UITabBarController) -> Coordinator
}

struct AppFactoryImp: AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController, tabNavigation: UITabBarController) -> Coordinator {
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinator(navigation: navigation, tabNavigation: tabNavigation, homeFactory: homeFactory)
        return homeCoordinator
    }
}

//
//  AppFactory.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

@MainActor
protocol AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator
}

struct AppFactoryImp: AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinator(navigation: navigation, homeFactory: homeFactory)
        return homeCoordinator
    }
}

@MainActor
protocol AppTabFactory {
    func makeHomeTabCoordinator(navigation: UITabBarController) -> TabCoordinator
}

struct AppTabFactoryImp: AppTabFactory {
    func makeHomeTabCoordinator(navigation: UITabBarController) -> TabCoordinator {
        let homeFactory = HomeTabFactoryImp()
        let homeCoordinator = HomeTabCoordinator(navigation: navigation, homeFactory: homeFactory)
        return homeCoordinator
    }
}

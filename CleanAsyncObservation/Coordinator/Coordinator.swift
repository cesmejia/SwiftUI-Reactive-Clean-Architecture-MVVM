//
//  Coordinator.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

@MainActor
protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}

@MainActor
protocol TabCoordinator {
    var tabNavigation: UITabBarController { get }
    func start()
}

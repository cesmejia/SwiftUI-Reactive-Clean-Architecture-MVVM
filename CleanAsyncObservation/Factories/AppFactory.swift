//
//  AppFactory.swift
//  CleanRxSwift
//
//  Created by Ces Mejia on 04/08/24.
//

import UIKit

@MainActor
protocol AppFactory {
    func makeHomeCoordinator(
        navigation: UINavigationController,
        tabNavigation: UITabBarController,
        todosDataSource: TodosDataSource
    ) -> Coordinator
    
    func makeCompletedTodosCoordinator(
        navigation: UINavigationController,
        tabNavigation: UITabBarController
    ) -> Coordinator
    
    func makeTodosDataSource() -> GetTodosRepository
}

struct AppFactoryImp: AppFactory {
    func makeHomeCoordinator(
        navigation: UINavigationController,
        tabNavigation: UITabBarController,
        todosDataSource: TodosDataSource
    ) -> Coordinator {
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinator(
            navigation: navigation,
            tabNavigation: tabNavigation,
            homeFactory: homeFactory,
            getTodosSource: todosDataSource
        )
        return homeCoordinator
    }
    
    func makeCompletedTodosCoordinator(
        navigation: UINavigationController,
        tabNavigation: UITabBarController
    ) -> Coordinator {
        let homeFactory = CompletedTodosFactoryImp()
        let homeCoordinator = CompletedTodosCoordinator(navigation: navigation, tabNavigation: tabNavigation, completedTodosFactory: homeFactory)
        return homeCoordinator
    }
}

extension AppFactoryImp {
    func makeTodosDataSource() -> GetTodosRepository {
        let todosService = TodosServiceImp()
        let todosDatabase = TodosDatabaseImp()
        let todosMemoryDatabase = TodosMemoryDatabaseImp()
        let todosDataSourceRemote = TodosRemoteDataGateway(
            todosService: todosService,
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let todosDataSourceLocal = TodosLocalDataGateway(
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let getTodosSource = GetTodosRepository(todosRemoteDataSource: todosDataSourceRemote, todosLocalDataSource: todosDataSourceLocal)
        return getTodosSource
    }
}

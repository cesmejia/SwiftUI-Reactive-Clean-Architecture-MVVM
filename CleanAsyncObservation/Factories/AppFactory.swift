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
        getTodosUseCase: GetTodosUseCase
    ) -> Coordinator
    
    func makeCompletedTodosCoordinator(
        navigation: UINavigationController,
        getTodosUseCase: GetTodosUseCase
    ) -> Coordinator
    
    func makeTodosUseCase() -> GetTodosUseCase
}

struct AppFactoryImp: AppFactory {
    func makeHomeCoordinator(
        navigation: UINavigationController,
        getTodosUseCase: GetTodosUseCase
    ) -> Coordinator {
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinator(
            navigation: navigation,
            homeFactory: homeFactory,
            getTodosUseCase: getTodosUseCase
        )
        return homeCoordinator
    }
    
    func makeCompletedTodosCoordinator(
        navigation: UINavigationController,
        getTodosUseCase: GetTodosUseCase
    ) -> Coordinator {
        let completedTodosFactory = CompletedTodosFactoryImp()
        let completedTodosCoordinator = CompletedTodosCoordinator(
            navigation: navigation,
            completedTodosFactory: completedTodosFactory,
            getTodosUseCase: getTodosUseCase
        )
        return completedTodosCoordinator
    }
}

extension AppFactoryImp {
    func makeTodosUseCase() -> GetTodosUseCase {
        let todosService = TodosServiceImp()
        let todosDatabase = TodosDatabaseImp()
        let todosMemoryDatabase = TodosMemoryDatabaseImp()
        let getTodosUseCaseRemote = TodosRemoteDataGateway(
            todosService: todosService,
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let getTodosUseCaseLocal = TodosLocalDataGateway(
            todosDatabase: todosDatabase,
            todosMemoryDatabase: todosMemoryDatabase
        )
        let getTodosSource = GetTodosRepository(todosRemoteDataSource: getTodosUseCaseRemote, todosLocalDataSource: getTodosUseCaseLocal)
        let getTodosUseCase = GetTodosUseCase(todosDataSource: getTodosSource)
        return getTodosUseCase
    }
}

//
//  TodosServiceImp.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "Framework Remote", category: "Todos Service")

class TodosServiceImp: TodosService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchTodos() async throws(RemoteDataSourceError) -> [Todo] {
        logger.info("Fetching TODOs")
        let (data, urlResponse) = try! await urlSession.data(from: URL(string: Constants.TODO.baseURL + Constants.TODO.todosEndpoint)!)
        
        guard let urlResponse = urlResponse as? HTTPURLResponse else { throw .invalidResponse }
        guard urlResponse.statusCode == 200 else { throw .not200Response }
        
        do {
            let todos = try JSONDecoder().decode([Todo].self, from: data)
            logger.info("Succesfully fetched TODOs: \(todos.count)")
            return todos
        } catch {
            logger.error("Error Fetching TODOs: \(error.localizedDescription)")
            throw .decodingError
        }
    }
}


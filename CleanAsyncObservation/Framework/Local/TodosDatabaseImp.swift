//
//  TodosDatabaseImp.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "Framework Local", category: "Todos Database")

class TodosDatabaseImp: TodosDatabase {
    var directoryURL: URL?
    
    init(directoryURL: URL? = nil) {
        self.directoryURL = directoryURL
    }
    
    func queryTodos() async throws(LocalDataSourceError) -> [Todo] {
        do {
            let todos = try await loadTodos()
            logger.info("Succesfully queried TODOs from FileManager database: \(todos.count)")
            return todos
        } catch {
            logger.error("Error querying FileManager TODOs: \(error)")
            throw .unknown
        }
    }
    
    func updateTodos(with todos: [Todo]) async throws(LocalDataSourceError) {
        do {
            try await save(todos: todos)
            logger.info("Succesfully updated FileManager TODOs: \(todos.count)")
        } catch {
            logger.error("Error updating FileManager TODOs: \(error)")
            throw .unknown
        }
    }
    
    // MARK: - FileManager
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("todos.data")
    }
    
    private func loadTodos() async throws -> [Todo] {
        let fileURL = try directoryURL ?? fileURL()
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        let todos = try JSONDecoder().decode([Todo].self, from: data)
        return todos
    }
    
    private func save(todos: [Todo]) async throws {
        let data = try JSONEncoder().encode(todos)
        let outfile = try directoryURL ?? fileURL()
        try data.write(to: outfile)
    }
}

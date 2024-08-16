//
//  Todo.swift
//  CleanObservation
//
//  Created by Ces Mejia on 09/08/24.
//

import Foundation

struct Todo: Codable, Equatable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

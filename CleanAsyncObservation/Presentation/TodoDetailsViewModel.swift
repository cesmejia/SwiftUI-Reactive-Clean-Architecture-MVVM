//
//  TodoDetailsViewModel.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import Foundation

@MainActor
@Observable class TodoDetailsViewModel {
    var todo: Todo
    
    init(
        todo: Todo
    ) {
        self.todo = todo
    }
}

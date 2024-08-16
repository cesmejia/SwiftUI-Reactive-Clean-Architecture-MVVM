//
//  ViewDidLoadModifier.swift
//  CleanAsyncObservation
//
//  Created by Ces Mejia on 16/08/24.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() async -> Void)?
    
    func body(content: Content) -> some View {
        content
            .task {
                if viewDidLoad == false {
                    viewDidLoad = true
                    await action?()
                }
            }
    }
}

extension View {
    func onViewDidLoadTask(perform action: (() async -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}

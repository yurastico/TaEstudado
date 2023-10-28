//
//  ContentView.swift
//  TaEstudado
//
//  Created by Yuri Cunha on 28/10/23.
//

import SwiftUI

enum NavigationType {
    case form
}

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            StudyPlanListView(path: $path)
                .navigationDestination(for: NavigationType.self) { type in
                    switch type {
                    case .form:
                        StudyPlanFormView(path: $path)
                    }
                }
        }
        
    }
}

#Preview {
    ContentView()
}

//
//  Recipe_App.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import SwiftUI
import SwiftData

@main
struct Recipe_App: App {
    let container: ModelContainer
    let viewModel: RecipeViewModel
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    seedDatabase(viewModel: viewModel)
                }
        }
        .modelContainer(container)
        .environment(viewModel)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Recipe.self)
        } catch {
            fatalError("""
                    Failed to create ModelContainer for Recipe. 
                    If you made a change to the Model, then uninstall 
                    the app and restart it from Xcode
                    """)
        }
        viewModel = RecipeViewModel(context: container.mainContext)
    }
}

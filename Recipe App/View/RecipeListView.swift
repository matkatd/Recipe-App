//
//  RecipeListView.swift
//  Recipe App
//
//  Created by David T on 11/16/24.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    
    let category: Category?
    let recipes: [Recipe]
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink {
                    RecipePage(recipe: recipe)
                } label: {
                    Text("\(recipe.title)")
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle(category?.name ?? "All Recipes")
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteRecipes(offsets: offsets)
    }
}

#Preview {
    RecipeListView(
        category: Category(name: "French"),
        recipes:[
            Recipe(
                title: "Quiche Lorraine",
                ingredients: [Ingredient(name: "Gruyere cheese", unit: "g", amount: 150.0)],
                instructions: ["Make the Quiche", "Eat the quiche"]),
            Recipe(title: "Cake", ingredients: [], instructions: []),
            Recipe(title: "Pizza", ingredients: [], instructions: [])
        ]
    )
            
    
}

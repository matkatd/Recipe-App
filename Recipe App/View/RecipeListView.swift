//
//  RecipeListView.swift
//  Recipe App
//
//  Created by David T on 11/16/24.
//

import SwiftUI
import SwiftUIX

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    
    let category: Category?
    
    let recipes: [Recipe]
    
    
    @State private var searchText: String = ""
    @State private var isCreateRecipeShowing = false
    
    var filteredItems: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.categories.contains(where: { $0.name.localizedCaseInsensitiveContains(searchText) })
                || $0.ingredients.contains(where: { $0.name.localizedCaseInsensitiveContains(searchText) })
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredItems) { recipe in
                NavigationLink {
                    RecipePage(recipe: recipe)
                        .navigationTitle(recipe.title)
                } label: {
                    Text("\(recipe.title)")
                }
            }
            .onDelete(perform: deleteItems)
        }
        .searchable(text:$searchText)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteRecipes(offsets: offsets)
        }
    }
}

#Preview {
    RecipeListView(
        category: Category(name: "French"),
        recipes:[
            Recipe(
                title: "Quiche Lorraine",
                ingredients: [Ingredient(name: "Gruyere cheese", unit: "g", amount: 150.0)],
                instructions: ["Make the Quiche", "Eat the quiche"], difficulty: Difficulty.Intermediate),
            Recipe(title: "Cake", ingredients: [], instructions: [], difficulty: Difficulty.Beginner),
            Recipe(title: "Pizza", ingredients: [], instructions: [], difficulty: Difficulty.Beginner)
        ]
    )
    
    
}

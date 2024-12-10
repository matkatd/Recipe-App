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
    
    @State var recipes: [Recipe]
    
    @State private var searchString: String = ""
    @State private var isCreateRecipeShowing = false
    
    var filteredItems: [Recipe] {
        if searchString.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.title.localizedCaseInsensitiveContains(searchString)
                || $0.categories.contains(where: { $0.name.localizedCaseInsensitiveContains(searchString) })
                || $0.ingredients.contains(where: { $0.name.localizedCaseInsensitiveContains(searchString) })
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(filteredItems) { recipe in
                    NavigationLink {
                        RecipePage(recipe: recipe)
                    } label: {
                        Text("\(recipe.title)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            .searchable(text: $searchString, prompt: "Search")
            .navigationTitle(category?.name ?? "All Recipes")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: {isCreateRecipeShowing = true}) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isCreateRecipeShowing) {
            CreateRecipeView(editRecipe: nil, onClose: { isCreateRecipeShowing = false })
        }
        
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
                instructions: ["Make the Quiche", "Eat the quiche"], difficulty: Difficulty.Intermediate),
            Recipe(title: "Cake", ingredients: [], instructions: [], difficulty: Difficulty.Beginner),
            Recipe(title: "Pizza", ingredients: [], instructions: [], difficulty: Difficulty.Beginner)
        ]
    )
    
    
}

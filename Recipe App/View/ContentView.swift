//
//  ContentView.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    
    @State private var isCreateRecipeShowing = false
    @State private var isEditing = false
    
    
    // MARK: - Main Body
    
    var body: some View {
        NavigationSplitView {
            categoriesList
                .navigationTitle("David's Recipes")
        }
        content: {
            primaryView
                .navigationTitle("David's Recipes")
        } detail: {
            Text("Select a Recipe")
        }
        
    }
    
    // MARK: - Other views
    
    var primaryView: some View {
        RecipeListView(category: Category(name: "All recipes"), recipes: viewModel.recipes)
            .toolbar {
                primaryToolbar
            }
    }
    
    var categoriesList: some View {
        List {
            NavigationLink {
                RecipeListView(category: Category(name: "All recipes"), recipes: viewModel.recipes)
                    .toolbar {
                        primaryToolbar
                    }
                    .navigationTitle("All recipes")
                    
            } label: {
                Text("All Recipes (\(viewModel.recipes.count))")
            }
            NavigationLink {
                RecipeListView(category: Category(name: "Favorites"), recipes: viewModel.favorites)
                    .toolbar {
                        primaryToolbar
                    }
                    .navigationTitle("Favorites")
                
            } label: {
                Text("Favorites (\(viewModel.favorites.count))")
            }
            ForEach(viewModel.categories) { category in
                NavigationLink {
                    RecipeListView(category: category, recipes: category.recipes ?? [])
                        .toolbar {
                            primaryToolbar
                        }
                        .navigationTitle(category.name)
                        
                } label: {
                    Text("\(category.name) (\(category.recipes?.count ?? 0))")
                }
            }
        }

        .sheet(isPresented: $isCreateRecipeShowing) {
            CreateRecipeView(editRecipe: nil, onClose: { isCreateRecipeShowing = false })
        }
    }
    

    private var primaryToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: { isCreateRecipeShowing = true }) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
    
    private func addItem() {
        viewModel.addRecipe(recipe: Recipe(title: "Cookies", ingredients: [Ingredient(name: "eggs", unit: "", amount: 2), Ingredient(name: "chocolate chips", unit: "cups", amount: 1)], instructions: ["Make cookies", "eat cookies"], prepTime: 900, cookTime: 1200, serves: 4, author: "David Thompson", difficulty: Difficulty.Beginner), categoryNames: ["Dessert", "Favorite"] )
    }
    
    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteRecipes(offsets: offsets)
    }
}

#Preview {
    ContentView()
        .modelContainer(for:[ Recipe.self, Category.self], inMemory: true)
}

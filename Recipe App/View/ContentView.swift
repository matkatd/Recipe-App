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
    
    @State private var searchString: String = ""
    @State private var isCreateRecipeShowing = false

    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    RecipeListView(category: Category(name: "All recipes"), recipes: viewModel.recipes)
                } label: {
                    Text("All Recipes (\(viewModel.recipes.count))")
                }
                ForEach(viewModel.categories) { category in
                    NavigationLink {
                        RecipeListView(category: category, recipes: category.recipes ?? [])
                    } label: {
                        Text("\(category.name) (\(category.recipes?.count ?? 0))")
                    }
                }
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
            .navigationTitle("David's Recipes")
            .sheet(isPresented: $isCreateRecipeShowing) {
                CreateRecipeView()
            }
        }
        content: {
            RecipeListView(category: Category(name: "All recipes"), recipes: viewModel.recipes)
            .searchable(text: $searchString)
        } detail: {
            Text("Select a Recipe")
        }
        
        
    }

    private func addItem() {
        viewModel.addRecipe(recipe: Recipe(title: "Cookies", ingredients: [Ingredient(name: "eggs", unit: "", amount: 2), Ingredient(name: "chocolate chips", unit: "cups", amount: 1)], instructions: ["Make cookies", "eat cookies"], prepTime: 900, cookTime: 1200, serves: 4, author: "David Thompson"), categoryNames: ["Dessert", "Favorite"] )
    }

    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteRecipes(offsets: offsets)
    }
}

#Preview {
    ContentView()
        .modelContainer(for:[ Recipe.self, Category.self], inMemory: true)
}

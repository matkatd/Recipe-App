//
//  RecipeViewModel.swift
//  Recipe App
//
//  Created by David T on 11/19/24.
//

import SwiftUI
import SwiftData

@Observable class RecipeViewModel {
    
    // MARK: - Properties
    
    let modelContext: ModelContext
    
    
    // MARK: - Initialization
    
    init(context: ModelContext) {
        self.modelContext = context
        fetchData()
    }
    
    
    
    // MARK: - Model Access
    private(set) var recipes: [Recipe] = []
    
    private(set) var favorites: [Recipe] = []
    
    private(set) var categories: [Category] = []
    
    // MARK: - Public Helpers
    
    func getCategoriesToAdd(_ categoryNames: [String]) -> [Category] {
        var categoriesToAdd: [Category] = []
        for category in categoryNames {
            if let existingCategory = fetchCategory(named: category) {
                categoriesToAdd.append(existingCategory)
            } else {
                let newCategory = Category(name: category)
                categoriesToAdd.append(newCategory)
            }
        }
        return categoriesToAdd
    }
    
    // MARK: - Private Helpers
    
    
    func saveAllChanges() {
        try? modelContext.save()
    }
    
    private func fetchData() {
        fetchRecipes()
        fetchCategories()		
        fetchFavorites()
    }
    
    private func fetchCategories() {
        saveAllChanges()
        
        do {
            let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\.name)])
            
            categories = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load categories")
        }
    }
    
    func fetchCategory(named name: String) -> Category? {
        // Fetch the category with the given name from the database
        let context = modelContext
        let descriptor = FetchDescriptor<Category>(
            predicate:  #Predicate {$0.name == name}
        )
        
        do {
            // Perform the fetch request and return the first result (if any)
            let categories = try context.fetch(descriptor)
            return categories.first
        } catch {
            print("Failed to fetch category: \(error)")
            return nil
        }
    }
    
    private func fetchRecipes() {
        
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load recipes: \(error)")
        }
    }
    
    private func fetchFavorites() {
        do {
            let descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate {$0.isFavorite},
                sortBy: [SortDescriptor(\.title)]
            )
            favorites = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load favorites: \(error)`")
        }
    }
    
    
    
    // MARK: - User Intents

    
    func updateRecipe(_ recipe: Recipe) {
        saveAllChanges()
        fetchData()
    }
    
    func addRecipe(recipe: Recipe, categoryNames: [String]) {
        withAnimation {
            print("making new item")
            let categoriesToAdd = getCategoriesToAdd(categoryNames)
            recipe.categories.append(contentsOf: categoriesToAdd)
            
            modelContext.insert(recipe)
            fetchData()
        }
    }
    
    
    func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
    
    func toggleFavorite(for recipe: Recipe) {
        withAnimation {
            
        }
    }
}





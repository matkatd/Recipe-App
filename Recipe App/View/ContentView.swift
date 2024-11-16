//
//  ContentView.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]
    @Query private var categories: [Category]

    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    RecipeListView(category: Category(name: "All recipes"), recipes: recipes)
                } label: {
                    Text("All Recipes")
                }
                ForEach(categories) { category in
                    NavigationLink {
                        RecipeListView(category: category, recipes: recipes.filter { $0.categories?.contains(category) ?? false })
                    } label: {
                        Text("\(category.name)")
                    }
                }
                
                

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a Recipe")
        }
    }

    private func addItem() {
        withAnimation {
            print("making new item")
            let newItem = Recipe(title: "cool recipe \(Int.random(in: 1..<100))", ingredients: [Ingredient(name: "Garlic", unit: Unit(name: "clove(s)", type: Unit.UnitType.nonConvertable), amount: 2)], instructions: ["some instructions"])
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for:[ Recipe.self, Category.self], inMemory: true)
}

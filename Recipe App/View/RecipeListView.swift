//
//  RecipeListView.swift
//  Recipe App
//
//  Created by David T on 11/16/24.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(\.modelContext) private var modelContext
    
    let category: Category?
    let recipes: [Recipe]
    
    var body: some View {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        Text("Recipe \(recipe.title)")
                    } label: {
                        Text("\(recipe.title)")
                    }
                }
                .onDelete(perform: deleteItems)
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
    RecipeListView(
        category: Category(name: "French"),
        recipes:[
            Recipe(
                title: "Quiche Lorraine",
                ingredients: [Ingredient(name: "Gruyere cheese", unit: Unit(name: "g", type: Unit.UnitType.convertable), amount: 150.0)],
                instructions: ["Make the Quiche", "Eat the quiche"]),
            Recipe(title: "Cake", ingredients: [], instructions: []),
            Recipe(title: "Pizza", ingredients: [], instructions: [])
        ]
    )
            
    
}

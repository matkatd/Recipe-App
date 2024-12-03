//
//  RecipePage.swift
//  Recipe App
//
//  Created by David T on 11/23/24.
//

import SwiftUI

struct RecipePage: View {
    @Environment(RecipeViewModel.self) private var viewModel
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            // Categories Section
            Text("Categories:")
                .font(.title2)
                .padding(.top, 16)
                .fontWeight(.bold)
            HStack {
                ForEach(recipe.categories) { category in
                    Text(category.name)
                        .padding(10)
                        .background(Color(.cyan))
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 16)

            detailsSection
            ingredientsSection
            directionsSection
            
            Spacer()
        }
        .navigationTitle(recipe.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: favoriteRecipe) {
                    Label("Favorite Recipe", systemImage: recipe.isFavorite ? "heart.fill" : "heart")
                }
            }
            ToolbarItem {
                EditButton()
            }
            
            
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top) // Fill vertical space and align to top
        .background(Color(.systemBackground)) // Optional: Set background color
    }
    
    var detailsSection: some View {
        // Recipe Info Section
        VStack(alignment: .leading, spacing: 8) {
            Text("Details")
            Divider()
            Text("Prep Time: \(formattedTime(recipe.prepTime))")
                .font(.subheadline)
            Text("Cook Time: \(formattedTime(recipe.cookTime))")
                .font(.subheadline)
            Text("Serves: \(recipe.serves ?? 0)")
                .font(.subheadline)
            Text("Author: \(recipe.author ?? "Unknown")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    var ingredientsSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients:")
                .font(.title2)
                .padding(.top, 16)
                .fontWeight(.bold)
            ForEach(recipe.ingredients) { ingredient in
                Text(formattedIngredient(ingredient))
            }
        }
    }
    
    var directionsSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            // Instructions Section
            Text("Instructions:")
                .font(.title2)
                .padding(.top, 16)
                .fontWeight(.bold)
            ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .font(.body)
                        .fontWeight(.bold)
                    Text(instruction)
                        .font(.body)
                        .lineLimit(nil)
                }
            }
        }
    }
    private func formattedTime(_ time: TimeInterval?) -> String {
        guard let time = time else { return "N/A" }
        let minutes = Int(time / 60)
        return "\(minutes) min"
    }
    
    private func formattedIngredient(_ ingredient: Ingredient) -> String {
        "• \(ingredient.amount.formatted()) \(ingredient.unit) \(ingredient.name)"
    }
    
    private func favoriteRecipe() {
        viewModel.toggleFavorite(for: recipe)
    }
}




#Preview {
    RecipePage(recipe: Recipe(
        title: "Quiche Lorraine",
        ingredients: [Ingredient(name: "Gruyere cheese", unit: "g", amount: 150.0)],
        instructions: ["Make the Quiche", "Eat the quiche"],
        prepTime: 10.0,
        cookTime: 10.0,
        serves: 4,
        author: "David Thompson"
    )
    )
}

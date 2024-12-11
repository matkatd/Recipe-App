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
    
    @State private var isEditRecipeShowing = false
    
    var body: some View {
        
        ScrollView {
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
            .padding()
        }
        .navigationTitle(recipe.title)
        
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: favoriteRecipe) {
                    Label("Favorite Recipe", systemImage: recipe.isFavorite ? "heart.fill" : "heart")
                }
            }
            ToolbarItem {
                Button(action: {
                    isEditRecipeShowing = true
                }) {
                    Label("Edit Recipe", systemImage: "pencil")
                }
            }
        }
        .sheet(isPresented: $isEditRecipeShowing) {
            CreateRecipeView(editRecipe: self.recipe, onClose: { isEditRecipeShowing = false })
        }
        
    }
    
    var detailsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Details")
            Divider()
            Text("Prep Time: \(recipe.prepTime.formattedTime()) min")
                .font(.subheadline)
            Text("Cook Time: \(recipe.cookTime.formattedTime()) min")
                .font(.subheadline)
            Text("Serves: \(recipe.serves)")
                .font(.subheadline)
            Text("Difficulty: \(String(describing: recipe.difficulty))")
                .font(.subheadline)
            Text("Author: \(recipe.author)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Date Created: \(recipe.dateCreated)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
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
    
    
    private func formattedIngredient(_ ingredient: Ingredient) -> String {
        if (ingredient.unit != nil) {
            "• \(ingredient.amount.formatted()) \(ingredient.unit ?? "") \(ingredient.name)"
        } else {
            "• \(ingredient.amount.formatted()) \(ingredient.name)"
        }
    }
    
    private func favoriteRecipe() {
        recipe.isFavorite.toggle()
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
        author: "David Thompson",
        difficulty: Difficulty.Intermediate
    )
    )
}

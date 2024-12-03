//
//  CreateRecipeView.swift
//  Recipe App
//
//  Created by David T on 11/29/24.
//

import SwiftUI

struct CreateRecipeView: View {
    @State private var isPresentingIngredientPage = false
    @State private var isPresentingInstructionPage = false
    
    @State var title = ""
    @State var author = ""
    @State var categories = ""
    @State var prepTime = ""
    @State var cookTime = ""
    @State var servings = ""
    @State var ingredients: [Ingredient] = []
    @State var instructions: [String] = []
    
    
    var body: some View {
        Form {
            Section("Details") {
                TextField("Recipe Name", text: $title)
                
                TextField("Author", text: $author)
                TextField("Categories", text: $categories)
                HStack {
                    TextField("Prep Time", text: $prepTime)
                    TextField("Cook Time", text: $cookTime)
                }
                TextField("Servings", text: $servings)
            }
            
            Section(header: Text("Ingredients")) {
                // Display list of ingredients
                if ingredients.isEmpty {
                    Text("No ingredients added yet.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.name) // Display ingredient name
                    }
                }
                
                // Button to add a new ingredient
                Button(action: {
                    isPresentingIngredientPage = true
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("Add Ingredient")
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
                .foregroundColor(.blue)
            }
            
            Section(header: Text("Instructions")) {
                // Display list of instructions
                if ingredients.isEmpty {
                    Text("No instructions added yet.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(Array(instructions.enumerated()), id: \.offset) { index, instruction in
                        Text(instruction) // Display ingredient name
                    }
                }
                
                // Button to add a new instruction
                Button(action: {
                    isPresentingInstructionPage = true
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("Add Instruction")
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
                .foregroundColor(.blue)
            }
            
            Button(action: {
                // Combine all the things and create the recipe
            }) {
                HStack {
                    Spacer()
                    Text("Create Recipe")
                    Spacer()
                }
            }
            .buttonStyle(.borderless)
            .foregroundColor(.blue)
            
        }
        .navigationTitle("New Recipe")
        .sheet(isPresented: $isPresentingIngredientPage) {
            CreateIngredientView()
        }
        .sheet(isPresented: $isPresentingInstructionPage) {
            CreateInstructionView()
        }
    }
}

#Preview {
    CreateRecipeView()
}

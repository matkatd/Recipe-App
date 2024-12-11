//
//  CreateRecipeView.swift
//  Recipe App
//
//  Created by David T on 11/29/24.
//

import SwiftUI

struct CreateRecipeView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    let editRecipe: Recipe?
    
    @State private var isPresentingIngredientPage = false
    @State private var isPresentingInstructionPage = false
    @State private var ingredientToEdit: Ingredient? = nil
    @State private var instructionToEdit: (String, Int)? = nil
    
    @State var title = ""
    @State var author = ""
    @State var categories = ""
    @State var prepTime = ""
    @State var cookTime = ""
    @State var servings = ""
    @State var ingredients: [Ingredient] = []
    @State var instructions: [String] = []
    @State var difficulty: Difficulty = .Beginner
    @State var isFavorite: Bool = false
    
    var onClose: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    VStack {
                        TextField("Recipe Name", text: $title)
                        Divider()
                        TextField("Author", text: $author)
                        Divider()
                        VStack(alignment: .leading, spacing: 4) {
                            TextField("Categories", text: $categories)
                            Text("Enter categories as a comma separated list.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Divider()
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                TextField("Prep Time", text: $prepTime)
                                Text("Enter the time required to prepare the ingredients, in minutes.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                TextField("Cook Time", text: $cookTime)
                                Text("Enter the time required to cook the recipe, in minutes.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Divider()
                        TextField("Servings", text: $servings)
                        Divider()
                        Picker("Difficulty", selection: $difficulty) {
                            ForEach(Difficulty.allCases) { difficulty in
                                Text(difficulty.rawValue)
                            }
                        }
                        Divider()
                        Toggle(isOn: $isFavorite) {
                            Text("Favorite")
                        }
                    }
                }
                
                Section(header: Text("Ingredients")) {
                    // Display list of ingredients
                    if ingredients.isEmpty {
                        Text("No ingredients added yet.")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(ingredients) { ingredient in
                            Text("\(ingredient.amount.formatted()) \(ingredient.unit ?? "") \(ingredient.name)") // Display ingredient name
                                .onTapGesture {
                                    ingredientToEdit = ingredient
                                    isPresentingIngredientPage = true
                                }
                        }
                        .onDelete { indexSet in
                            ingredients.remove(atOffsets: indexSet)
                        }
                    }
                    
                    // Button to add a new ingredient
                    Button(action: {
                        isPresentingIngredientPage = true
                        ingredientToEdit = nil
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
                            Text("\(index + 1). \(instruction)") // Display ingredient name
                                .onTapGesture {
                                    instructionToEdit = (instruction, index)
                                    isPresentingInstructionPage = true
                                }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                instructions.remove(at: index)
                            }
                        }
                    }
                    
                    // Button to add a new instruction
                    Button(action: {
                        isPresentingInstructionPage = true
                        instructionToEdit = nil
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
                
                Button(action: { saveRecipe() }) {
                    HStack {
                        Spacer()
                        Text(isEditing ? "Modify Recipe" : "Create Recipe")
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
                .foregroundColor(.blue)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {onClose()}) {
                        Text("Cancel")
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Recipe" : "New Recipe")
            .sheet(isPresented: $isPresentingIngredientPage) {
                // I asked ChatGPT how to pass data from a child component to the parent, and this is what it told me to do
                CreateIngredientView(ingredient: ingredientToEdit, onClose: { isPresentingIngredientPage = false }) {
                    newIngredient in
                    if let index = ingredients.firstIndex(where: { $0.id == newIngredient.id }) {
                        ingredients[index] = newIngredient // Update existing ingredient
                    } else {
                        ingredients.append(newIngredient) // Add new ingredient
                    }
                    isPresentingIngredientPage = false
                }
            }
            .sheet(isPresented: $isPresentingInstructionPage) {
                CreateInstructionView(instruction: instructionToEdit?.0, onClose: { isPresentingInstructionPage = false }) {
                    newInstruction in
                    if let index = instructionToEdit?.1 {
                        instructions[index] = newInstruction // Update existing instruction
                    } else {
                        instructions.append(newInstruction) // Add new instruction
                    }
                    isPresentingInstructionPage = false
                }
            }
            
        }
        .onAppear {
            if let editRecipe = editRecipe {
                title = editRecipe.title
                author = editRecipe.author
                cookTime = editRecipe.cookTime.formattedTime()
                prepTime = editRecipe.prepTime.formattedTime()
                difficulty = editRecipe.difficulty
                ingredients = editRecipe.ingredients
                instructions = editRecipe.instructions
                servings = String(editRecipe.serves)
                categories = editRecipe.categoryList()
                isFavorite = editRecipe.isFavorite
            }
        }
    }
    
    private var isEditing: Bool {
        editRecipe != nil
    }
    
    private func saveRecipe() {
        if isEditing {
            if let recipeToEdit = editRecipe {
                recipeToEdit.author = author
                // We are multiplying by 60 to make it back into a proper TimeInterval
                // Since TimeIntervals store seconds
                recipeToEdit.cookTime = (Double(cookTime) ?? 0) * 60
                recipeToEdit.difficulty = difficulty
                recipeToEdit.ingredients = ingredients
                recipeToEdit.instructions = instructions
                recipeToEdit.prepTime = (Double(prepTime) ?? 0) * 60
                recipeToEdit.serves = Int(servings) ?? 0
                recipeToEdit.title = title
                recipeToEdit.categories = stringToCategories(categories)
                recipeToEdit.isFavorite = isFavorite
                print(recipeToEdit.prepTime)
                viewModel.updateRecipe(recipeToEdit)
            }
            
        } else {
            let recipe = Recipe(title: title, ingredients: ingredients, instructions: instructions, prepTime: Double(prepTime) ?? 0, cookTime: Double(cookTime) ?? 0, serves: Int(servings) ?? 0, author: author, difficulty: difficulty, isFavorite: isFavorite)
            
            viewModel.addRecipe(recipe: recipe, categoryNames: stringToStringArray(categories))
        }
        onClose()
    }
    
    private func stringToCategories(_ categories: String) -> [Category] {
        // categories will be a comma separated string, so we need to parse that out
        let categoryNames = stringToStringArray(categories)
        return viewModel.getCategoriesToAdd(categoryNames)
    }
    
    private func stringToStringArray(_ categories: String) -> [String] {
        categories.components(separatedBy: ", ")
    }
    
}



#Preview {
    CreateRecipeView(editRecipe: nil, onClose: {})
}

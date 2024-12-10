import SwiftUI
import SwiftData

@MainActor
func seedDatabase(viewModel: RecipeViewModel) {
    // Check if there are any recipes
    let recipeCount = viewModel.recipes.count
    guard recipeCount == 0 else { return } // Database already initialized
    
    // Create Recipes
    let pancakes = Recipe(
        title: "Fluffy Pancakes",
        ingredients: [
            Ingredient(name: "All-purpose flour", unit: "cups", amount: 1.0),
            Ingredient(name: "Baking powder", unit: "teaspoons", amount: 2.0),
            Ingredient(name: "Sugar", unit: "tablespoons", amount: 1.0),
            Ingredient(name: "Milk", unit: "cups", amount: 1.0),
            Ingredient(name: "Egg", amount: 1.0)
        ],
        instructions: [
            "Mix the dry ingredients in a bowl.",
            "Whisk the milk and egg together in a separate bowl.",
            "Combine wet and dry ingredients until smooth.",
            "Heat a non-stick pan and pour 1/4 cup batter for each pancake.",
            "Cook until bubbles form, then flip and cook the other side."
        ],
        prepTime: 300,
        cookTime: 600,
        serves: 4,
        author: "David T",
        difficulty: .Beginner,
        isFavorite: true
    )
    
    let spaghettiBolognese = Recipe(
        title: "Spaghetti Bolognese",
        ingredients: [
            Ingredient(name: "Spaghetti", unit: "grams", amount: 500.0),
            Ingredient(name: "Ground beef", unit: "grams", amount: 300.0),
            Ingredient(name: "Tomato sauce", unit: "cups", amount: 2.0),
            Ingredient(name: "Onion", amount: 1.0),
            Ingredient(name: "Garlic", unit: "cloves", amount: 2.0)
        ],
        instructions: [
            "Cook spaghetti according to package instructions.",
            "Sauté chopped onions and garlic in a pan until golden.",
            "Add ground beef and cook until browned.",
            "Stir in tomato sauce and simmer for 15 minutes.",
            "Serve sauce over spaghetti."
        ],
        prepTime: 600,
        cookTime: 1200,
        serves: 4,
        author: "David T",
        difficulty: .Intermediate,
        isFavorite: false
    )
    
    let chocolateCake = Recipe(
        title: "Chocolate Cake",
        ingredients: [
            Ingredient(name: "All-purpose flour", unit: "cups", amount: 1.5),
            Ingredient(name: "Cocoa powder", unit: "cups", amount: 0.75),
            Ingredient(name: "Sugar", unit: "cups", amount: 1.0),
            Ingredient(name: "Baking soda", unit: "teaspoons", amount: 1.5),
            Ingredient(name: "Milk", unit: "cups", amount: 1.0)
        ],
        instructions: [
            "Preheat the oven to 350°F (175°C).",
            "Mix all dry ingredients in a large bowl.",
            "Add milk and stir until smooth.",
            "Pour batter into a greased baking pan.",
            "Bake for 30-35 minutes or until a toothpick comes out clean."
        ],
        prepTime: 900,
        cookTime: 2100,
        serves: 8,
        author: "David T",
        difficulty: .Intermediate,
        isFavorite: true
    )

    let caesarSalad = Recipe(
        title: "Caesar Salad",
        ingredients: [
            Ingredient(name: "Romaine lettuce", unit: "heads", amount: 1.0),
            Ingredient(name: "Caesar dressing", unit: "cups", amount: 0.5),
            Ingredient(name: "Croutons", unit: "cups", amount: 1.0),
            Ingredient(name: "Parmesan cheese", unit: "tablespoons", amount: 2.0)
        ],
        instructions: [
            "Wash and chop the romaine lettuce.",
            "Toss lettuce with Caesar dressing.",
            "Top with croutons and grated Parmesan.",
            "Serve immediately."
        ],
        prepTime: 600,
        cookTime: 0,
        serves: 2,
        author: "David T",
        difficulty: .Beginner,
        isFavorite: false
    )

    let vegetableSoup = Recipe(
        title: "Vegetable Soup",
        ingredients: [
            Ingredient(name: "Carrots", amount: 2.0),
            Ingredient(name: "Celery", unit: "stalks", amount: 2.0),
            Ingredient(name: "Potatoes", amount: 2.0),
            Ingredient(name: "Vegetable broth", unit: "cups", amount: 4.0),
            Ingredient(name: "Salt", unit: "teaspoons", amount: 1.0)
        ],
        instructions: [
            "Chop all vegetables into bite-sized pieces.",
            "Bring vegetable broth to a boil in a large pot.",
            "Add vegetables and simmer for 20 minutes.",
            "Season with salt to taste and serve hot."
        ],
        prepTime: 600,
        cookTime: 1200,
        serves: 4,
        author: "David T",
        difficulty: .Beginner,
        isFavorite: true
    )
    // Add more recipes as needed

    // Insert into the database

    viewModel.addRecipe(recipe: pancakes, categoryNames: ["Breakfast"])
    viewModel.addRecipe(recipe: spaghettiBolognese, categoryNames: ["Dinner"])
    viewModel.addRecipe(recipe: chocolateCake, categoryNames: ["Dessert"])
    viewModel.addRecipe(recipe: caesarSalad, categoryNames: ["Dinner"])
    viewModel.addRecipe(recipe: vegetableSoup, categoryNames: ["Dinner"])

}


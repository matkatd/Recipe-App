//
//  Recipe.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import Foundation
import SwiftData

@Model
final class Recipe: Identifiable {
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipe)
    var ingredients: [Ingredient]
    var instructions: [String]
    @Relationship(inverse: \Category.recipes)
    var categories: [Category] = []
    var prepTime: TimeInterval
    var cookTime: TimeInterval
    var serves: Int
    var author: String
    var dateCreated: Date = Date()
    var difficulty: Difficulty
    var isFavorite: Bool
    

    
    init(
        title: String,
        ingredients: [Ingredient],
        instructions: [String],
        prepTime: TimeInterval = 0,
        cookTime: TimeInterval = 0,
        serves: Int = 0,
        author: String = "",
        difficulty: Difficulty,
        isFavorite: Bool = false
    ) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.serves = serves
        self.author = author
        self.difficulty = difficulty
        self.isFavorite = isFavorite
    }
}

extension Recipe {
    func categoryList() -> String {
        return categories.map { $0.name }.joined(separator: ", ")
    }
}

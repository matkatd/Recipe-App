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
    var prepTime: TimeInterval?
    var cookTime: TimeInterval?
    var serves: Int?
    var author: String?
    var isFavorite: Bool
    

    
    init(
        title: String,
        ingredients: [Ingredient],
        instructions: [String],
        prepTime: TimeInterval? = nil,
        cookTime: TimeInterval? = nil,
        serves: Int? = nil,
        author: String? = nil,
        isFavorite: Bool = false
    ) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.serves = serves
        self.author = author
        self.isFavorite = isFavorite
    }
}

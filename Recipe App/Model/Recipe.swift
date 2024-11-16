//
//  Recipe.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var ingredients: [Ingredient]
    var instructions: [String]
    var categories: [Category]?
    var prepTime: TimeInterval?
    var cookTime: TimeInterval?
    var author: String?
    
    init(title: String, ingredients: [Ingredient], instructions: [String]) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
    }
}

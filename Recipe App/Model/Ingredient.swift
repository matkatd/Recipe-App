//
//  Ingredient.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var name: String
    var unit: Unit
    var amount: Double
    init(name: String, unit: Unit, amount: Double) {
        self.name = name
        self.unit = unit
        self.amount = amount
    }
}

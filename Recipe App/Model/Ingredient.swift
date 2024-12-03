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
    var unit: String
    var amount: Double
    
    var recipe: Recipe?
    
    init(name: String, unit: String, amount: Double) {
        self.name = name
        self.unit = unit
        self.amount = amount
    }
}

extension Double {
    func formatted(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 // Adjust based on precision needs
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

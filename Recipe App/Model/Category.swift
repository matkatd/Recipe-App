//
//  Category.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    var name: String
    
    var recipes: [Recipe]?
    
    init(name: String) {
        self.name = name
    }
}

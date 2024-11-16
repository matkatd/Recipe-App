//
//  Unit.swift
//  Recipe App
//
//  Created by David T on 11/14/24.
//

import Foundation
import SwiftData



@Model
final class Unit {
    var name: String
    var typeRawValue: String // For persistence

    // Computed property to access the enum
    var type: UnitType {
        get { UnitType(rawValue: typeRawValue) ?? .nonConvertable }
        set { typeRawValue = newValue.rawValue }
    }

    enum UnitType: String { // Backed by String for persistence
        case convertable
        case nonConvertable
    }

    init(name: String, type: UnitType) {
        self.name = name
        self.typeRawValue = type.rawValue
    }
    

}

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
    var type: UnitType = UnitType.nonConvertable
    
    init(name: String, type: UnitType) {
        self.name = name
        self.type = type
    }
    
    enum UnitType {
        case convertable;
        case nonConvertable;
    }
}

//
//  Difficulty.swift
//  Recipe App
//
//  Created by David T on 12/3/24.
//

import Foundation

enum Difficulty: String, CaseIterable, Codable, Identifiable  {
    case Beginner
    case Intermediate
    case Expert
    var id: Self { self }
}

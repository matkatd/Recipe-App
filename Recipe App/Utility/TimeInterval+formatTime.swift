//
//  DateTime+formatTime.swift
//  Recipe App
//
//  Created by David T on 12/10/24.
//

import Foundation

extension TimeInterval {
    func formattedTime() -> String {
        let minutes = Int(self / 60)
        return "\(minutes)"
    }
}

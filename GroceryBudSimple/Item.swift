//
//  Item.swift
//  GroceryBudSimple
//
//  Created by Adam Buryšek on 22.06.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

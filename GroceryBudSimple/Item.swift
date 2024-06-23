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
    var name: String
    var isBuyed: Bool
    
    init(timestamp: Date, name: String, isBuyed: Bool) {
        self.timestamp = timestamp
        self.name = name
        self.isBuyed = isBuyed
    }
}

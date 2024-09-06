//
//  TableData.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import Foundation
import Observation

struct ConsumableItem: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    var calories: Int
    var included: Bool
}

@Observable class TableData {
    var items: [ConsumableItem] = []

    init() {
        items = [
            ConsumableItem(name: "Bagels", category: "Baked", calories: 250, included: false),
            ConsumableItem(name: "Brownies", category: "Baked", calories: 466, included: false),
            ConsumableItem(name: "Butter", category: "Dairy", calories: 717, included: false),
            ConsumableItem(name: "Cheese", category: "Dairy", calories: 402, included: false),
            ConsumableItem(name: "Juice", category: "Beverages", calories: 23, included: false),
            ConsumableItem(name: "Lemonade", category: "Beverages", calories: 40, included: false)
        ]
    }
}

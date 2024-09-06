//
//  HierarchicalData.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import Foundation
import Observation

struct MainItem: Identifiable {
    let id = UUID()
    let name: String
    var options: [MainItem]!
}

@Observable class HierarchicalData {
    var items: [MainItem] = []

    init() {
        items = [
            MainItem(name: "Food", options: [
                MainItem(name: "Oatmeal", options: nil),
                MainItem(name: "Bagels", options: nil),
                MainItem(name: "Brownies", options: nil),
                MainItem(name: "Cheese", options: [
                    MainItem(name: "Roquefort", options: nil),
                    MainItem(name: "Mozzarella", options: nil),
                    MainItem(name: "Cheddar", options: nil)
                ]),
                MainItem(name: "Cookies", options: nil),
                MainItem(name: "Donuts", options: nil)
            ]),
            MainItem(name: "Beverages", options: [
                MainItem(name: "Coffee", options: nil),
                MainItem(name: "Juice", options: nil),
                MainItem(name: "Lemonade", options: nil)
            ])
        ]
    }
}

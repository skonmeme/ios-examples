//
//  TableView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

struct TableView: View {
    @Environment(TableData.self) var tableData: TableData

    var body: some View {
        Table(of: ConsumableItem.self, columns: {
            TableColumn("Name", value: \.name)
            TableColumn("Category", value: \.category)
            TableColumn("Calories") { item in
                Text("\(item.calories)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }.width(100)
        }, rows: {
            TableRow(ConsumableItem(name: "STANDARD", category: "", calories: 0, included: false))
            ForEach(tableData.items)
        })
    }
}

#Preview {
    TableView()
        .environment(TableData())
}

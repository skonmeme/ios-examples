//
//  ListView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

struct ListView: View {
    var hierachicalData = HierarchicalData()

    var body: some View {
        List {
            ForEach(hierachicalData.items) { item in
                Section(header: Text(item.name)) {
                    OutlineGroup(item.options ?? [], children: \.options) { subitem in
                        Text(subitem.name)
                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
}

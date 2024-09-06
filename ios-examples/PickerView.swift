//
//  PickerView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

struct PickerView: View {
    @State private var selected: Int = 0
    let cities: [String] = ["Paris", "Toronto", "Dublin"]

    var body: some View {
        VStack {
            Text(cities[selected])
                .font(.largeTitle)
                .padding()
            Picker("Cities:", selection: $selected) {
                ForEach(cities.indices, id: \.self) {
                    Text(cities[$0])
                    .tag($0)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            selected = 0
        }
    }
}

#Preview {
    PickerView()
}

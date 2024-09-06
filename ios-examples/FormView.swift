//
//  FormView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

struct FormView: View {
    @State private var active: Bool = false
    @State private var showPictures: Bool = false
    @State private var total: Int = 10

    var body: some View {
        Form {
            Section(header: Text("Options"), footer: Text("Activate the options you want to see")) {
                Toggle("Active", isOn: $active)
                Toggle("Show Pictures", isOn: $showPictures)
            }
            Section(header: Text("Value"), footer: Text("Choose the number of items to display")) {
                LabeledContent("Total") {
                    Text("\(total)")
                    Stepper("", value: $total, in: 0...10)
                        .labelsHidden()
                }
            }
        }
    }
}

#Preview {
    FormView()
}

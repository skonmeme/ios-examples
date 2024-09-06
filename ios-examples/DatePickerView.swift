//
//  DatePickerView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

struct DatePickerView: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            DatePicker("Date:", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    DatePickerView()
}

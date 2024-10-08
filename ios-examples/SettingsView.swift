//
//  SettingsView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/10/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showPictures: Bool = true
    @State private var showYear: Bool = true

    var body: some View {
        Form {
            Toggle("Show Pictures", isOn: $showPictures)
            Toggle("Show Year", isOn: $showYear)
        }.navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

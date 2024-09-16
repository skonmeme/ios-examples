//
//  SettingsViewForTabView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/11/24.
//

import SwiftUI

struct SettingsViewForTabView: View {
    @EnvironmentObject var settings: BookViewSettings

    var body: some View {
        Form {
            Section(header: Text("Book Display Options"), footer: Text("Select what you want to see")) {
                Toggle("Show Pictures", isOn: $settings.showPictures)
                Toggle("Show Year", isOn: $settings.showYears)
            }
        }
    }
}

#Preview {
    SettingsViewForTabView()
    .environmentObject(BookViewSettings())
}

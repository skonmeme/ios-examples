//
//  ContentTabView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/11/24.
//

import SwiftUI

struct ContentTabView: View {
    @StateObject var bookshelfData = BookshelfData()
    @StateObject var settings = BookViewSettings()
    @State private var selectedTab = "books"

    var body: some View {
        TabView {
            BookshelfView()
            .environmentObject(bookshelfData)
            .environmentObject(settings)
            .tabItem {
                Label("Books", systemImage: "book.circle")
            }
            .tag("books")
            SettingsViewForTabView()
            .environmentObject(settings)
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            //.badge(1)
            .badge(0)
            .tag("settings")
        }
    }
}

#Preview {
    ContentTabView()
}

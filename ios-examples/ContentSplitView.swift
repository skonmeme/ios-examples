//
//  ContentSplitView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/12/24.
//

import SwiftUI

struct ContentSplitView: View {
    @StateObject var bookshelfData = BookshelfData()
    @State private var selectedBook: Book?
    @State private var path = NavigationPath()
    @State private var visibility: NavigationSplitViewVisibility = .automatic

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility, sidebar: {
            NavigationStack { 
                BooksView(selectedBook: $selectedBook)
                .environmentObject(bookshelfData)
            }
        }, detail: {
            NavigationStack(path: $path) {
                if let book = selectedBook {
                    DetailViewForSplit(path: $path, book: book)
                } else {
                    PlaceholderView()
                }
            }
        })
        .onChange(of: selectedBook, initial: false) { _, _ in
            path = NavigationPath()
        }
    }
}

#Preview {
    ContentSplitView()
    .environmentObject(BookshelfData())
}

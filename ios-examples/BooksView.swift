//
//  BooksView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/12/24.
//

import SwiftUI

struct BooksView: View {
    @EnvironmentObject var bookshelfData: BookshelfData
    @Binding var selectedBook: Book?

    var body: some View {
        List(bookshelfData.books, selection: $selectedBook) { book in
            NavigationLink(value: book, label: {
                Text(book.title )
            })
        }
        .listStyle(.sidebar)
        .navigationTitle("Books")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: "Settings View", label: {
                    Image(systemName: "gear")
                })
                .isDetailLink(false)
            }
        }
        .navigationDestination(for: String.self, destination: { _ in
            SettingsView()
        })
    }
}

#Preview {
    BooksView(selectedBook: .constant(nil))
    .environmentObject(BookshelfData())
}

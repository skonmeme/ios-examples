//
//  BooksViewForTabView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/11/24.
//

import SwiftUI

struct BookshelfView: View {
    @EnvironmentObject var bookshelfData: BookshelfData
    @EnvironmentObject var settings: BookViewSettings

    var body: some View {
        List(bookshelfData.books) { book in
            BookViewForTabView(book: book)
        }
    }
}

#Preview {
    BookshelfView()
    .environmentObject(BookshelfData())
    .environmentObject(BookViewSettings())
}

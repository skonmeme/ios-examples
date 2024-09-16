//
//  BookViewForTabView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/11/24.
//

import SwiftUI

class BookViewSettings: ObservableObject {
    @Published var showPictures: Bool
    @Published var showYears: Bool

    init() {
        self.showPictures = true
        self.showYears = true
    }
}

struct BookViewForTabView: View {
    @EnvironmentObject var settings: BookViewSettings
    var book: Book

    var body: some View {
        HStack {
            if settings.showPictures {
                Image(book.cover)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 100)
            }

            VStack(alignment: .leading) {
                Text(book.title)
                    .bold()
                Text(book.author)
                if settings.showYears {
                    Text(book.displayYear)
                        .font(.caption)
                }
                Spacer()
            }
            .padding(.top, 5)
            Spacer()
        }
    }
}

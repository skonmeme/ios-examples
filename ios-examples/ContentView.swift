//
//  ContentView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(ApplicationData.self) var applicationData: ApplicationData
    @State private var selectedBookIDs: Set<Book.ID> = []

    let colors = [.white, Color(white: 0.95)]

    var booksByInitial: [(key: String, value: [Book])] {
        let listGroup: [String: [Book]] = Dictionary(grouping: applicationData.books, by: {
            let first = String($0.title.prefix(1))
            if first.range(of: "\\p{Hangul}", options: .regularExpression) != nil {
                let firstConsonant = first.unicodeScalars.first!.value
                if firstConsonant >= 0xAC00 && firstConsonant <= 0xD7A3 {
                    let index = (firstConsonant - 0xAC00) / 28 / 21
                    let consonant = UnicodeScalar(0x1100 + index)!
                    return String(consonant)
                } else {
                    return first.uppercased()
                }
            }
            return first.uppercased()
        })
        return listGroup.sorted(by: { $0.key < $1.key })
    }

    var body: some View {
        List(selection: $selectedBookIDs) {
            ForEach(booksByInitial, id: \.key) { element in
                Section(header: Text(String(element.key))) {
                    ForEach(element.value) { book in
                        let index = element.value.firstIndex(where: { $0.id == book.id }) ?? 0
                        BookView(book: book)
                            .listRowBackground(index % 2 == 0 ? colors[0] : colors[1])
                            .listRowSeparator(.hidden)
                    }.onDelete { indexSet in
                        applicationData.books.remove(atOffsets: indexSet)
                    }
                }
                .headerProminence(.increased)
                .listSectionSeparator(.hidden)
                .refreshable {
                    print("Loading new data...")
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct BookView: View {
    @Environment(ApplicationData.self) var applicationData: ApplicationData
    let book: Book

    var body: some View {
        HStack {
            Image(book.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)

            VStack(alignment: .leading) {
                Text(book.title)
                    .bold()
                Text(book.author)
                Text(book.displayYear)
                    .font(.caption)
                Spacer()
            }
            .padding(.top, 5)
            Spacer()

            Button(action: {
                removeBook(book: book)
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
            })
            .padding(.top, 5)
            .buttonStyle(PlainButtonStyle())
        }
    }

    func removeBook(book: Book) {
        if let index = applicationData.books.firstIndex(where: { $0.id == book.id }) {
            applicationData.books.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
        .environment(ApplicationData())
}

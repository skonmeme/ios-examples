//
//  ContentView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI
import Foundation

enum SearchScope {
    case title, author
}

struct Token: Identifiable, Equatable {
    let id = UUID()
    let name: String
}

struct ContentView: View {
    @Environment(ApplicationData.self) var applicationData: ApplicationData
    @State private var searchTerm: String = ""
    @State private var searchScope: SearchScope = .title
    @State private var searchTokens: [Token] = []

    var body: some View {
        NavigationStack {
            BookListView(searchTokens: $searchTokens)
        }
        .searchable(text: $searchTerm, tokens: $searchTokens, token: { token in
            Text(token.name)
        })
        //.searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search books"))
        //.searchScopes($searchScope, scopes: {
        //    Text("Title").tag(SearchScope.title)
        //    Text("Author").tag(SearchScope.author)
        //})
        //.searchSuggestions {
        //    ForEach(applicationData.selectedBooks) { item in
        //        Text("\(item.title) - \(item.author)").searchCompletion(item.title)
        //    }
        //}
        // Enable search only on submit
        //.onSubmit(of: .search) {
        //    let trimmed = searchTerm.trimmingCharacters(in: .whitespaces)
        //    performSearch(search: trimmed)
        //}
        .onChange(of: searchTerm, initial: false) { _, _ in
            performSearch()
        }
        //.onChange(of: searchScope, initial: false) { _, _ in
        //    performSearch()
        //}
        .onChange(of: searchTokens, initial: false) { _, _ in
            performSearch()
        }
    }

    func performSearch() {
        let search = searchTerm.trimmingCharacters(in: .whitespaces)
        applicationData.filter(search: search, author: searchTokens.first?.name ?? "")
    }
}

struct BookListView: View {
    @Environment(ApplicationData.self) var applicationData: ApplicationData
    @Binding var searchTokens: [Token]
    let colors = [.white, Color(white: 0.95)]

    var body: some View {
        List(applicationData.indexedBooks, id: \.key) { element in
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
        .listStyle(PlainListStyle())
        .navigationTitle(Text("Books"))
        .toolbar {
            let authorList = applicationData.selectedBooks.map { $0.author }
            let authors = Set(authorList).sorted()
            Menu(content: {
                ForEach(authors, id: \.self) { author in
                    Button(action: {
                        let token = Token(name: author)
                        searchTokens.append(token)
                    }, label: {
                        Text(author)
                    })
                }
            }, label: {
                Image(systemName: "pencil.circle")
            })
        }
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

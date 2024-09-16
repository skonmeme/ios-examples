//
//  AddBookView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/10/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData
    @Environment(\.dismiss) private var dismiss
    @State private var titleInput: String = ""
    @State private var authorInput: String = ""
    @State private var yearInput: String = ""
    @State private var cover: String = "nocover"
    @State private var openAlert: Bool = false
    var book: Book?

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Text(book == nil ? "Add book" : "Edit book")
                    .font(.title)
                Spacer()
                Button("Cancel") {
                    dismiss()
                }.padding([.top, .bottom], 10)
            }
            TextField("Insert Title", text: $titleInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.top, .bottom], 10)
            TextField("Insert Author", text: $authorInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.top, .bottom], 10)
            TextField("Insert Year", text: $yearInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numbersAndPunctuation)
                .padding([.top, .bottom], 10)
            Image(cover)
                .resizable()
                .scaledToFit()
                .padding([.top, .bottom], 10)
            HStack {
                Spacer()
                Button("Add") {
                    openAlert = true
                }.buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            if let book = book {
                titleInput = book.title
                authorInput = book.author
                yearInput = String(book.year)
                cover = book.cover
            }
        }
        //.alert("Confirm", isPresented: $openAlert, actions: {
        //    Button("Cancel", role: .cancel, action: {})
        //    Button("Confirm", role: .none) {
        //        storeBook()
        //        dismiss()
        //    }
        //}, message: {
        //    Text("Are you sure you want to add this book?")
        //})
        .confirmationDialog("Confirm?", isPresented: $openAlert, actions: {
            Button("Cancel", role: .cancel, action: {})
            Button("Confirm", role: .none) {
                storeBook()
                dismiss()
            }
        }, message: {
            Text("Are you sure you want to add this book?")
        })
    }

    func storeBook() {
        let title = titleInput.trimmingCharacters(in: .whitespaces)
        let author = authorInput.trimmingCharacters(in: .whitespaces)
        if let year = Int(yearInput), !title.isEmpty && !author.isEmpty && !cover.isEmpty {
            if let index = applicationData.books.firstIndex(where: { $0.id == book?.id }) {
                let newBook = Book(title: title, author: author, cover: cover, year: year, selected: false)
                applicationData.books[index] = newBook
            } else {
                let newBook = Book(title: title, author: author, cover: "nocover", year: year, selected: false)
                applicationData.books.append(newBook)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddBookView()
        .environment(ApplicationData())
    }
}

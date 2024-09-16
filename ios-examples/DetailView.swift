//
//  DetailView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/10/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.horizontalSizeClass) var horizontal
    @State var path: NavigationPath = NavigationPath()
    let book: Book

    var body: some View {
        Group {
            if horizontal == .regular {
                HorizontalDetailView(path: $path, book: book)
            } else {
                VerticalDetailView(path: $path, book: book)
            }
        }
        .padding()
        .navigationTitle("Information")
        //.navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: String.self, destination: { _ in
            PictureView(book: book)
        })
    }
}

struct HorizontalDetailView: View {
    @Binding var path: NavigationPath
    let book: Book

    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    path.append("Picture View")
                }, label: {
                    Image(book.cover)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                })
                Spacer()
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.title)
                Text(book.author)
                    .font(.subheadline)
                Text(book.displayYear)
                    .font(.caption)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct VerticalDetailView: View {
    @Binding var path: NavigationPath
    let book: Book

    var body: some View {
        VStack {
            Text(book.title)
                .font(.title)
            Text(book.author)
                .font(.subheadline)
            Text(book.displayYear)
                .font(.caption)
            Button(action: {
                path.append("Picture View")
            }, label: {
                Image(book.cover)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300)
            })
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    NavigationStack {
        DetailView(book: ApplicationData().selectedBooks[1])
    }
}

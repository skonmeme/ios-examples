//
//  PictureView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/12/24.
//

import SwiftUI

struct PictureView: View {
    @Environment(\.horizontalSizeClass) var horizontal
    var book: Book

    var body: some View {
        VStack {
            if horizontal == .regular {
                Image(book.cover)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 50)
            } else {
                Image(book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
            }
            Spacer()
        }
        //.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PictureView(book: BookshelfData().books[1])
    }
}

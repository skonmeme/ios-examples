//
//  ConcurrentCotentView.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/15/24.
//

import SwiftUI

struct ConcurrentCotentView: View {
    let imageSite = URL(string: "https://www.formasterminds.com/images/coveruikit4big.png")

    var body: some View {
        VStack {
            AsyncImage(url: imageSite, content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }, placeholder: {
                Image(.nopicture)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            })
        }
    }
}

#Preview {
    ConcurrentCotentView()
}

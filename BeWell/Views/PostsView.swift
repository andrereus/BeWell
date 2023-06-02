//
//  PostsView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct PostsView: View {
    @Binding var allDataOriginal: [Post]
    
    var body: some View {
        NavigationView {
            List(allDataOriginal) { item in
                if (item.type == "quote" && item.reported != "1") {
                    Text(item.quote)
                } else if (item.type == "image" && item.reported != "1") {
                    AsyncImage(url: URL(string: SVars.postImgUrl.appending(item.image))) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .navigationBarTitle("PostsView", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: AddView()) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

//
//  PostsView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct PostsView: View {
    @Binding var postsData: [Post]
    @Binding var usersData: [User]
    @Binding var categoriesData: [Category]
    @Binding var serverOutput: [String: String]
    @Binding var postForm: PostForm
    
    var body: some View {
        NavigationView {
            List(postsData) { item in
                if (item.reported != "1") {
                    VStack(alignment: .leading) {
                        Text(userName(uid: item.uid)).font(.subheadline).padding(.vertical, 2.0)
                    
                        if (item.type == "quote") {
                            Text(item.quote)
                            Text(item.quoteAuthor).font(.caption).padding(.vertical, 1.0)
                        } else if (item.type == "image") {
                            AsyncImage(url: URL(string: SVars.postImgUrl.appending(item.image))) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Posts", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: AddView(categoriesData: $categoriesData, serverOutput: $serverOutput, postForm: $postForm)) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    func userName(uid: String) -> String {
        return usersData.first(where: { $0.id == uid })?.username ?? "Unknown"
    }
}

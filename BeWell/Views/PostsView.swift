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

    @State private var selectedCategory: String = "all"

    var body: some View {
        NavigationView {
            VStack {
                Picker("Category", selection: $selectedCategory) {
                    Text("Alle Posts").tag("all")
                    
                    ForEach(categoriesData.filter { category in
                        postsData.contains { $0.category == category.id }
                    }, id: \.id) { category in
                        Text(category.name).tag(category.id)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                List(postsData.filter { post in
                    selectedCategory == "all" || post.category == selectedCategory
                }.sorted(by: { $0.timestamp > $1.timestamp })) { item in
                    if item.reported != "1" {
                        VStack(alignment: .leading) {
                            Text(userName(uid: item.uid)).font(.subheadline).padding(.vertical, 2.0)

                            if item.type == "quote" {
                                Text(item.quote)
                                Text(item.quoteAuthor).font(.caption).padding(.vertical, 1.0)
                            } else if item.type == "image" {
                                AsyncImage(url: URL(string: SVars.postImgUrl.appending(item.image))) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
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

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
    
    var body: some View {
        NavigationView {
            List(postsData) { item in
                if (item.reported != "1") {
                    VStack(alignment: .leading) {
                        Text(userName(uid: item.uid)).font(.caption).padding(.vertical, 2.0)
                    
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
                        
                        HStack {
                            // TODO: Like Anzahl
                            Button("Gefällt mir") {
                                // TODO
                            }.font(.caption)
                            Spacer()
                            Button("Melden") {
                                // TODO
                            }.font(.caption)
                        }.padding(.vertical, 2.0)
                    }
                }
            }
            .navigationBarTitle("Posts", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: AddView()) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    func userName(uid: String) -> String {
        return usersData.first(where: { $0.id == uid })?.username ?? "Unknown"
    }
}

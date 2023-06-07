//
//  ProfileView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct ProfileView: View {
    @Binding var serverOutput: [String: String]
    @Binding var postsData: [Post]
    
    var body: some View {
        NavigationView {
            VStack {
                Text(serverOutput["username"]!).font(.subheadline)
                
                List(userPosts) { item in
                    if (item.reported != "1") {
                        VStack(alignment: .leading) {
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
            }
            .navigationBarTitle("Profil", displayMode: .inline)
        }
    }
    
    var userPosts: [Post] {
        return postsData.filter { $0.uid == serverOutput["uid"]! }
    }
}

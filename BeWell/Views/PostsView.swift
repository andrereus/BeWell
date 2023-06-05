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
                if (item.reported != "1") {
                    VStack(alignment: .leading) {
                        Text(item.uid)
                        
                        if (item.type == "quote") {
                            Text(item.quote)
                            Text(item.quoteAuthor)
                        } else if (item.type == "image") {
                            AsyncImage(url: URL(string: SVars.postImgUrl.appending(item.image))) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        HStack {
                            // TODO: Like Anzahl
                            
                            Button(action: {
                                // TODO
                            }) {
                                Text("Gefällt mir")
                            }
                            
                            Button(action: {
                                // TODO
                            }) {
                                Text("Melden")
                            }
                        }
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
}

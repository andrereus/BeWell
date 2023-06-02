//
//  PostsView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct PostsView: View {
    var body: some View {
        NavigationView {
            Text("PostsView")
                .navigationBarTitle("PostsView", displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                    }
                )
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}

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
        VStack {
            Text(serverOutput["username"]!)
        }
    }
}

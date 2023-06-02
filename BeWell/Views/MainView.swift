//
//  MainView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var dc: DataController = DataController()
    
    @State var isLoggedIn: Bool = true
    @State var selectedTab: Int = 0
    
    var body: some View {
        if isLoggedIn {
            TabView(selection: $selectedTab) {
                PostsView()
                    .tabItem {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Posts")
                    }.tag(0)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profil")
                    }.tag(1)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Einstellungen")
                    }.tag(2)
            }
        } else {
            SignInView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

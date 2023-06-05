//
//  MainView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var dc: DataController = DataController()
    
    @State var isLoggedIn: Bool = false
    @State var selectedTab: Int = 0
    
    var body: some View {
        switch dc.pageIndex {
        case 0:
            SignInView(pageIndex: $dc.pageIndex)
        case 1:
            TabView(selection: $selectedTab) {
                PostsView(allDataOriginal: $dc.allDataOriginal)
                    .tabItem {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Posts")
                    }.tag(0)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profil")
                    }.tag(1)
                
                SettingsView(isLoggedIn: $isLoggedIn.onChange(updateLoggedIn))
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Einstellungen")
                    }.tag(2)
            }
        case 2:
            SignUpView(pageIndex: $dc.pageIndex)
        default:
            SignInView(pageIndex: $dc.pageIndex)
        }
    }
    
    func updateLoggedIn(value: Bool) {
        dc.signOut()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

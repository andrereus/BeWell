//
//  MainView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var dc: DataController = DataController()
    
    @State var selectedTab: Int = 0
    
    @State var signInFormData: [String: String] = ["email":"", "password":""]
    @State var signUpFormData: [String: String] = ["email":"", "password":"", "username": ""]
    
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        switch dc.pageIndex {
            case 0:
            SignInView(pageIndex: $dc.pageIndex, signInFormData: $signInFormData.onChange(sendSignInData))
            case 1:
                TabView(selection: $selectedTab) {
                    PostsView(allDataOriginal: $dc.allDataOriginal)
                        .tabItem {
                            Image(systemName: "rectangle.stack.fill")
                            Text("Posts")
                        }.tag(0)
                    
                    ProfileView(serverOutput: $dc.serverOutput)
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
                SignUpView(pageIndex: $dc.pageIndex, signUpFormData: $signUpFormData.onChange(sendSignUpData))
            default:
                SignInView(pageIndex: $dc.pageIndex, signInFormData: $signInFormData.onChange(sendSignInData))
        }
    }
    
    func updateLoggedIn(value: Bool) {
        dc.signOut()
    }
    
    func sendSignInData(value: [String: String]) {
        dc.checkSignIn(email: value["email"]!, password: value["password"]!)
    }
    
    func sendSignUpData(value: [String: String]) {
        dc.checkSignUp(email: value["email"]!, password: value["password"]!, username: value["username"]!)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

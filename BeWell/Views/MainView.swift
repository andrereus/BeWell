//
//  MainView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var dc: DataController = DataController()

    @State var postForm: PostForm = PostForm(type: "", image: Data(), quote: "", quoteAuthor: "", uid: "", category: "", reported: "")

    @State var selectedTab: Int = 0

    @State var signInFormData: [String: String] = ["email": "", "password": ""]
    @State var signUpFormData: [String: String] = ["email": "", "password": "", "username": ""]

    @State var isLoggedIn: Bool = false

    var body: some View {
        switch dc.pageIndex {
        case 0:
            SignInView(pageIndex: $dc.pageIndex, signInFormData: $signInFormData.onChange(sendSignInData))
        case 1:
            TabView(selection: $selectedTab) {
                PostsView(postsData: $dc.postsData, usersData: $dc.usersData, categoriesData: $dc.categoriesData, serverOutput: $dc.serverOutput, postForm: $postForm.onChange(sendPostData))
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Posts")
                }.tag(0)

                ProfileView(serverOutput: $dc.serverOutput, postsData: $dc.postsData)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profil")
                    }.tag(1)

                SettingsView(isLoggedIn: $isLoggedIn.onChange(updateLoggedIn), postsData: $dc.postsData)
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

    func sendPostData(postForm: PostForm) {
        dc.addPost(postForm: postForm)
    }

    func sendSignInData(value: [String: String]) {
        dc.checkSignIn(email: value["email"]!, password: value["password"]!)
    }

    func sendSignUpData(value: [String: String]) {
        dc.checkSignUp(email: value["email"]!, password: value["password"]!, username: value["username"]!)
    }

    func updateLoggedIn(value: Bool) {
        dc.signOut()
    }
}

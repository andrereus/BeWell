//
//  SignUpView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    
    @Binding var pageIndex: Int
    
    @Binding var signUpFormData: [String: String]
    
    var body: some View {
        VStack {
            Text("Registrieren").font(.title)
            
            TextField("E-Mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Passwort", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Nutzername", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            Button("Registrieren") {
                signUpFormData = ["email": email, "password": password, "username": username]
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Anmelden") {
                pageIndex = 0
            }
            .padding()
        }
        .padding()
    }
}

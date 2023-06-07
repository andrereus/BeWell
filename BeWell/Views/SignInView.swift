//
//  SignInView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var pageIndex: Int
    
    @Binding var signInFormData: [String: String]
    
    var body: some View {
        VStack {
            Text("Anmelden").font(.title)
            
            TextField("E-Mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Passwort", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Anmelden") {
                signInFormData = ["email": email, "password": password]
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Registrieren") {
                pageIndex = 2
            }
            .padding()
        }
        .padding()
    }
}

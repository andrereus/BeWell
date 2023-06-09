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
    
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Text("Registrieren").font(.title)

            TextField("E-Mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()

            SecureField("Passwort", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Nutzername", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()

            Button("Registrieren") {
                if !validateInput() {
                    showAlert = true
                } else {
                    signUpFormData = ["email": email, "password": password, "username": username]
                }
            }
            .buttonStyle(BorderedButtonStyle())

            Button("Anmelden") {
                pageIndex = 0
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Alle Felder müssen ausgefüllt sein!"), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
    
    func validateInput() -> Bool {
        guard !email.isEmpty else {
            return false
        }

        guard !password.isEmpty else {
            return false
        }
        
        guard !username.isEmpty else {
            return false
        }

        return true
    }
}

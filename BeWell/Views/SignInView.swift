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
    
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Text("Anmelden").font(.title)

            TextField("E-Mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()

            SecureField("Passwort", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Anmelden") {
                if !validateInput() {
                    showAlert = true
                } else {
                    signInFormData = ["email": email, "password": password]
                }
            }
            .buttonStyle(BorderedButtonStyle())

            Button("Registrieren") {
                pageIndex = 2
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

        return true
    }
}

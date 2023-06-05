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
    
    var body: some View {
        VStack {
            Text("Registrieren")
            
            TextField("E-Mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Passwort", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Nutzername", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                // TODO
            }) {
                Text("Registrieren")
            }
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

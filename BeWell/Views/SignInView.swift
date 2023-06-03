//
//  SignInView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct SignInView: View {
    @State var inputText: String = ""
    
    var body: some View {
        VStack() {
            SecureField("Input", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

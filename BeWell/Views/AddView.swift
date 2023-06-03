//
//  AddView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct AddView: View {
    @State var inputText: String = ""
    
    var body: some View {
        VStack() {
            TextField("Input", text: $inputText).textFieldStyle(RoundedBorderTextFieldStyle())
        }.padding()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

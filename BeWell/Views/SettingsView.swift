//
//  SettingsView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Button("Abmelden") {
                isLoggedIn = false
            }
        }
    }
}

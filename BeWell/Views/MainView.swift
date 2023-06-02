//
//  MainView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var dc: DataController = DataController()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

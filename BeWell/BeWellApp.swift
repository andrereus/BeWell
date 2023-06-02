//
//  BeWellApp.swift
//  BeWell
//
//  Created by Student on 01.06.23.
//

import SwiftUI

@main
struct BeWellApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
            // ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

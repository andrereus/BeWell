//
//  SettingsView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isLoggedIn: Bool
    @Binding var postsData: [Post]
    
    @AppStorage("notificationsEnabled") var notificationsEnabled = false

    var body: some View {
        NavigationView {
            VStack {
                Toggle("Benachrichtigungen", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { newValue in
                        if newValue {
                            let center = UNUserNotificationCenter.current()
                            
                            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                if granted {
                                    DispatchQueue.main.async {
                                        scheduleRandomQuoteNotification()
                                    }
                                } else {
                                    print("Berechtigung abgelehnt")
                                    DispatchQueue.main.async {
                                        notificationsEnabled = false
                                    }
                                }
                            }
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
                    .padding()
                
                Button("Abmelden") {
                    isLoggedIn = false
                }
                .buttonStyle(BorderedButtonStyle())
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Einstellungen", displayMode: .inline)
        }
    }

    func scheduleRandomQuoteNotification() {
        guard let randomPost = postsData.filter({ $0.type == "quote" && $0.reported != "1" }).randomElement() else { return }
        scheduleNotification(quote: randomPost.quote, author: randomPost.quoteAuthor)
    }

    func scheduleNotification(quote: String, author: String) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "BeWell"
        content.body = "\(quote) - \(author)"
        content.categoryIdentifier = "quote"
        content.sound = UNNotificationSound.default

        // Für Testing jede Minute eine Benachrichtigung
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Benachrichtigung hinzugefügt")
            }
        }
    }
}

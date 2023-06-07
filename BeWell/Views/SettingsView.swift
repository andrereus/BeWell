//
//  SettingsView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI

struct SettingsView: View {
    // TODO: Code überarbeiten
    
    @Binding var isLoggedIn: Bool
    @Binding var postsData: [Post]
    @State var notificationsEnabled = false

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
                                    print("Permission denied")
                                    DispatchQueue.main.async {
                                        notificationsEnabled = false
                                    }
                                }
                            }
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
                
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
        content.title = "Quote Notification"
        content.body = "\(quote) - \(author)"
        content.categoryIdentifier = "quote"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                // Handle any errors.
                print(error.localizedDescription)
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}

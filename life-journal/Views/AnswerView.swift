//
//  AnswerView.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/21/23.
//

import SwiftUI
import UserNotifications

struct AnswerView: View {
    @State private var permissionGranted = false
    
    private func requestPermissions(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                permissionGranted = true
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Answer your questions!"
        // TODO: add in random quotes
        notificationContent.subtitle = "It takes only one moment"
        
        // TODO: replace with question notif time
        var date = DateComponents()
        date.hour = 15
        date.minute = 30
        /*let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)*/
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let req = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req)
    }
    
    
    var body: some View {
        VStack {
            if !permissionGranted {
                Button("Request Permission") {
                    requestPermissions()
                }
            }
            if permissionGranted {
                Button("Send Notification") {
                    sendNotification()
                }
            }
        }
        .onAppear {
            // Check if we already have permissions to send notifications
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    permissionGranted = true
                }
            }
        }
        .padding()
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView()
    }
}

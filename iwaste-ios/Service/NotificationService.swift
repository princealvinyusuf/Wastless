//
//  NotificationService.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 04/11/20.
//

import Foundation
import UserNotifications

class NotificationService {
    static let instance = NotificationService()
    
    func scheduleDailyReminder() {
        var components = DateComponents()
        components.hour = 6
        components.minute = 30
        triggerNotification(
            title: "Daily Reminder",
            body: "Let’s start an awesome day by setting target for your waste production today.",
            date: components
        )
    }
    
    func triggerNotification(title: String, body: String, date: DateComponents, identifier: String = "com.infiniteloop.iwaste-ios.DAILY_REMINDER") {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .defaultCritical
        content.body = body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print("Something went wrong")
            }
        })
    }
    
    func scheduleNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                    
                    // Schedule Local Notification
                    self.scheduleDailyReminder()
                })
            case .authorized:
                // Schedule Local Notification
                self.scheduleDailyReminder()
            case .denied:
                print("Application Not Allowed to Display Notifications")
                
            default:
                print("Notification permission error")
            }
        }
    }
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
}

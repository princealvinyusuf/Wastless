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
    
    func scheduleLocalNotification() {
        let components = DateComponents()
        
        triggerNotification(title: "Badge Unlocked", body: "Yeayy, it seems one of your badge is unlocked, Go Check it now!", date: components)
    }
    
    func triggerNotification(title: String, body: String, date: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .defaultCritical
        content.body = body
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)

        let request = UNNotificationRequest(identifier: "TEST", content: content, trigger: notificationTrigger)
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
                            self.scheduleLocalNotification()
                        })
                    case .authorized:
                        // Schedule Local Notification
                        self.scheduleLocalNotification()
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

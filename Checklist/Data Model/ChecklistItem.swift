//
//  ChecklistItem.swift
//  Checklist
//
//  Created by 田冰 on 10/28/18.
//  Copyright © 2018 tianbing. All rights reserved.
//

import Foundation
import UserNotifications
class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    func toggleChecked() {
    checked = !checked
    }
    func scheduleNotification() {
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from:dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("Schedule: \(request) for itemID: \(itemID)")
        }
    }
}

//
//  NotificationSetViewController.swift
//  Notes
//
//  Created by Will Carty on 10/30/16.
//  Copyright © 2016 efa. All rights reserved.
//

import UIKit
import UserNotifications
class NotificationSetViewController: UIViewController {
    @IBOutlet weak var NotificationPicker: UIDatePicker!
    @IBOutlet weak var notificationSetDisplay: UILabel!
    
    var todoDVC = ToDoDetailViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {(granted, error) in
            
            if granted {
                print("Notification access granted")
                
            } else {
                print(error?.localizedDescription)
            }
        })
        
    }
    
    //IBActions
    @IBAction func notificationSetButton(_ sender: AnyObject) {
        let laterDate = NotificationPicker.date
        let currentDate = Date()
        let interval = laterDate.timeIntervalSince(currentDate)
        
        scheduleNotification(timeAndDate: interval, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error")
            }
        })
    }
    
    @IBAction func notificationDatePicker(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        let strDate = dateFormatter.string(from: NotificationPicker.date)
        self.notificationSetDisplay.text = strDate
    }
    
    func scheduleNotification(timeAndDate: TimeInterval, completion: @escaping (Bool) -> ()) {
        let notify = UNMutableNotificationContent()
        notify.title = "Reminder"
        notify.subtitle = "I-ToDo item Reminder"
        notify.body = "Your due date has arrived"
        
        let notifyTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeAndDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notify, trigger: notifyTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
}

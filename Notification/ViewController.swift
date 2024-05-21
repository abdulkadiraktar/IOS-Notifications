//
//  ViewController.swift
//  Notification
//
//  Created by Abdulkadir Aktar on 21.05.2024.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    var permissionCheck = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //bildirim izin isteme
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler:{ granted, error in
            self.permissionCheck = granted
            
            
        })
        UNUserNotificationCenter.current().delegate = self    }

    @IBAction func buttonNotification(_ sender: Any) {
        if permissionCheck {
            let content = UNMutableNotificationContent()
            content.title = "Başlık"
            content.subtitle = "Alt Başlık"
            content.body = "İçerik"
            content.badge = 1
            content.sound = UNNotificationSound.default
            
            //ne zaman tetiklenecek  //timeInterval 10 saniye sonra bildirim gözükecek çünkü uygulama açıkken bildirim gözükmez
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
}
// uygulama çalışırken de bildirim gelebilmesi için
extension ViewController : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound,.badge])
    }
    //bildirim seçildiğinde
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let app = UIApplication.shared
        
        if app.applicationState == .active {
            print("Önplan : Bildirim Seçildi")
        }
        if app.applicationState == .inactive {
            print("Arkaplan : Bildirim Seçildi")
        }
        
        //app.applicationIconBadgeNumber = 0 güncellemeden önceki hali
        center.setBadgeCount(0)
        
        print("Bildirim seçildi")
        completionHandler()
    }
}


//
//  File.swift
//  Sabotage
//
//  Created by 김하람 on 1/3/24.
//

import UIKit
import UserNotifications
import SwiftUI

class NotificationView: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // 알림 권한 요청
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (didAllow, error) in
                // 권한 요청 결과 처리
            }
            
            UNUserNotificationCenter.current().delegate = self

            // 버튼 생성 및 구성
            let button = UIButton(type: .system)
            button.setTitle("Notify", for: .normal)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        
            // 버튼 레이아웃 설정
            button.frame = CGRect(x: 100, y: 50, width: 100, height: 50)
            view.addSubview(button)
        }
    
    @IBAction func buttonPressed(_ sender: UIButton){
        
        for index in 1...5 {
            
            //Setting content of the notification
            let content = UNMutableNotificationContent()
            content.title = "This is title : Zedd"
            content.subtitle = "This is Subtitle : UserNotifications tutorial"
            content.body = "This is Body : 블로그 글 쓰기\nThis is Body : 블로그 글 쓰기"
            content.summaryArgument = "Alan Walker"
            content.summaryArgumentCount = 40
            
            //Setting time for notification trigger
            //블로그 예제에서는 TimeIntervalNotificationTrigger을 사용했지만, UNCalendarNotificationTrigger사용법도 같이 올려놓을게요!
            
            //1. Use UNCalendarNotificationTrigger
            let date = Date(timeIntervalSinceNow: 70)
            var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            let calendartrigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: true)
            
            
            //2. Use TimeIntervalNotificationTrigger
            let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
            
            //Adding Request
            // MARK: - identifier가 다 달라야만 Notification Grouping이 됩니닷..!!
            let request = UNNotificationRequest(identifier: "\(index)timerdone", content: content, trigger: TimeIntervalTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
    }
    
}

extension NotificationView : UNUserNotificationCenterDelegate {
    //To display notifications when app is running  inforeground
    
    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해줍니다.
    //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
    }
}

struct NotificationViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> NotificationView {
        // NotificationView의 인스턴스를 생성
        return NotificationView()
    }

    func updateUIViewController(_ uiViewController: NotificationView, context: Context) {
        // 필요한 경우 여기서 NotificationView를 업데이트합니다.
    }
}


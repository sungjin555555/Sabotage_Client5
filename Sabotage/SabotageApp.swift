//
//  SabotageApp.swift
//  Sabotage
//
//  Created by 김하람 on 12/27/23.
//

import SwiftUI
import FamilyControls

let deviceID = UIDevice.current.identifierForVendor!.uuidString

@main
struct ScreenTime_SabotageApp: App {
    @StateObject var familyControlsManager = FamilyControlsManager.shared
    @StateObject var scheduleVM = ScheduleVM()
    init() {
        handleRequestAuthorization()
        requestNotificationPermission()
        initUUID()
    }
    var body: some Scene {
        WindowGroup {
            VStack {
                // MARK: - ram 권한에 대한 조건 설정
                if !familyControlsManager.hasScreenTimePermission {
                    ContentView()
                } else {
//                    NotiView()
                    ContentView()
                }
            }
            .onReceive(familyControlsManager.authorizationCenter.$authorizationStatus) { newValue in
                // here
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    familyControlsManager.updateAuthorizationStatus(authStatus: newValue)
                }
            }
            .environmentObject(familyControlsManager)
            .environmentObject(scheduleVM)
        }
    }
}

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Notification Permission Granted.\(deviceID)")
            
        } else {
            print("Notification Permission Denied.\(deviceID)")
        }
    }
}
@MainActor
func handleRequestAuthorization() {
    FamilyControlsManager.shared.requestAuthorization()
}

struct ActionItemData : Codable {
    // 이 부분의 변수명들은 불러온 부분과 일치해야 함.
    let data : [DataList]
}

struct DataList : Codable {
    let id : Int
    let category : String
    let content : String
}


struct LimitItemData : Codable {
    // 이 부분의 변수명들은 불러온 부분과 일치해야 함.
    let data : [LimitDataList]
}

struct LimitDataList : Codable {
    let id: Int
    let title: String
    let timeBudget: Int
    let nudgeInterval: Int
}

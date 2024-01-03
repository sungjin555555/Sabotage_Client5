//
//  GoalGroup.swift
//  Sabotage
//
//  Created by 김하람 on 1/3/24.
//

import Foundation
import SwiftUI

func goalPostRequest(title: String, timeBudget: Int, nudgeInterval: Int) {
    // 서버 링크가 유요한지 확인
    guard let url = URL(string: "\(urlLink)goalGroup/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    print("✅ Valid URL = \(url)")
    // request 생성하기
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // json 형식으로 데이터 전송할 것임
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // POST로 요청할 경우 : json 형식으로 데이터 넘기기
    let body:[String: AnyHashable] = [
        "title": title,
        "timeBudget": timeBudget,
        "nudgeInterval": nudgeInterval
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    // data task 생성하기
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        // 응답 처리하기
        if let error = error {
            print("🚨 Error: \(error.localizedDescription)")
            return
        }
        
        // 데이터가 비어있는지 확인
        guard let data = data, !data.isEmpty else {
            print("✅ No data returned from the server")
            return
        }
        do {
            if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                print("✅ \(response)")
            }
        } catch {
            print("🚨 JSON parsing error: ", error)
        }
//        do {
//            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print("✅ Success: \(jsonResponse)")
//            
//            DispatchQueue.main.async {
//                // 필요한 경우 NotificationCenter를 사용하여 알림 보내기
//                // NotificationCenter.default.post(name: .addNotification, object: nil)
//            }
//        } catch {
//            print("🚨 Error parsing JSON: ", error)
//        }
    }
    // 시작하기. 꼭 적어줘야 함 !
    task.resume()
}
/**
 
 do {
     if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
         if let data = response["data"] as? [String: Any] {
             if let id = data["id"] as? Int {
                 UserDefaults.standard.set(id, forKey: "userID")
                 
                 print("ID: \(id)")
                 print("USERID: \(UserDefaults.standard.integer(forKey: "userID"))")
             }
             if let nickname = data["nickname"] as? String {
                 UserDefaults.standard.set(nickname, forKey: "nickname")
                 if let storedNickname = UserDefaults.standard.string(forKey: "nickname") {
                     print("nickname = \(storedNickname)")
                 }
             }
         }
         print("✅ \(response)")
     }
 } catch {
     print("🚨 JSON parsing error: ", error)
 }
 
 */

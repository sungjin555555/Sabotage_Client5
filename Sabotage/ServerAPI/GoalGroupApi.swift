//
//  GoalGroup.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/04.
//

import Foundation
import SwiftUI

extension Notification.Name {
    static let addLimitNotification = Notification.Name("addLimitNotification")
}

// MARK: Limit [Create]
func goalPostRequest(title: String, timeBudget: Int, nudgeInterval: Int) {
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
            DispatchQueue.main.async {
                 NotificationCenter.default.post(name: .addLimitNotification, object: nil)
                
                print("✅ [actionPostRequest] Notification posted in actionPostRequest")
            }
        } catch {
            print("🚨 JSON parsing error: ", error)
        }
    }
    // 시작하기. 꼭 적어줘야 함 !
    task.resume()
}













// MARK: Limit [Read]
func GroupGetData(title: String, timeBudget: String, nudgeInterval: String){
    if let url = URL(string: "\(urlLink)goalGroup/\(userId)") {
        let session = URLSession(configuration: .default)
        // 지정된 URL의 내용을 검색하는 작업을 만든(creat)다음, 완료시 handler(클로저)를 호출
        // 클로저 앞에 @escaping이 있으면 함수의 작업이 완료된 후에 클로저가 호출된다.
            // data: 서버에서 반환된 데이터
            // response: HTTP 헤더 및 상태 코드와 같은 응답 메타 데이터를 제공하는 객체
            // error: 요청이 실패한 이유
        // 작업 후에는 반드시 resume()를 호출해야 한다.
            // 작업이 일시중단된 경우 다시 시작하는 것
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            // JSON data를 가져온다. optional 풀어줘야 함
            if let JSONdata = data {
                let dataString = String(data: JSONdata, encoding: .utf8) //얘도 확인을 위한 코드임
                print(dataString!)
                // JSONDecoder 사용하기
                let decoder = JSONDecoder() // initialize

                // .self를 붙이는 것 = static metatype을 .self 라고 한다. 꼭 넣어줘야 한다.
                // 자료형이 아닌 변수 값을 써줘야 하므로 .self를 붙여준다.
                // try catch문을 사용해야 함
                do { //json형식으로 디코딩 한다.
//                    let decodeData = try decoder.decode(PardData.self, from: JSONdata)
//                    self.pardData = decodeData
                    // 데이터를 가져온 후 collectionView를 메인 스레드에서 리로드_반드시 해야 화면에서 보임.
                    DispatchQueue.main.async {
                        // reloadData를 써주면 된다. 다시 로드하기 위함.
                        NotificationCenter.default.post(name: .addLimitNotification, object: nil)
                        
                        print("✅ [actionPostRequest] Notification posted in actionPostRequest")
                    }
                } catch let error as NSError {
                    print("🚨", error)
                }
            }
        }
        // task가 준비만 하고 멈춰있기 때문.
        task.resume()
    }
}












// MARK: Limit [Update]
func GroupUpdateRequest(id : Int, title : String, timeBudget : String, nudgeInterval : String) {
    guard let url = URL(string: "\(urlLink)goalGroup/\(userId)/\(id)") else {
        print("🚨 Invalid URL")
        return
    }
    
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    let body:[String: AnyHashable] = [
        "title": title,
        "timeBudget": timeBudget,
        "nudgeInterval": nudgeInterval
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _gaet, error in
        guard let data = data, error == nil else {
            if let error = error {
                print("🚨🙊 Error: \(error.localizedDescription)")
            } else {
                print("🚨🙊 Data is nil")
            }
            return
        }
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ Update Success: \(jsonResponse)")
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .addNotification, object: nil)
            }
            
        } catch {
            print("🚨🚨 Error parsing JSON: ", error)
        }
        
    }
    task.resume()
}












// MARK: Limit [Delete]
func GroupdeleteRequest(id : Int, title : String, timeBudget : String, nudgeInterval : String) {
    
    guard let url = URL(string: "\(urlLink)goalGroup/\(userId)/\(id)") else {
        print("🚨 Invalid URL")
        return
    }
    
    print("⛑️ id = \(title) \(timeBudget) \(nudgeInterval)")
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("🚨 Error: \(error.localizedDescription)")
        } else if let data = data {
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("✅ Delete success: \(response)")
                NotificationCenter.default.post(name: .addNotification, object: nil)
            } catch {
                print("🚨 Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
    task.resume()
}
//// MARK: - Update _ 특정 데이터에 대한 값을 서버에 수정하는 함수
//func GroupUpdateRequest(userId : String, goalGroupId : String) {
//    guard let url = URL(string: "\(urlLink)actionItem/\(userId)") else {
//        print("🔆 Invalid URL")
//        return
//    }
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "PATCH"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    let body: [String: Any] = [
//          "title": "string",
//          "timeBudget": 0,
//          "nudgeInterval": 0
//    ]
//
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//    let task = URLSession.shared.dataTask(with: request) { data, _, error in
//        guard let data = data, error == nil else {
//            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
//            return
//        }
//        do {
//            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print("✅ Update success: \(response)")
//            DispatchQueue.main.async {
//                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .addLimitNotification, object: nil)
//
//                   print("✅ [actionPostRequest] Notification posted in actionPostRequest")                }
//            }
//        } catch {
//            print("🚨 ", error)
//        }
//    }
//    task.resume()
//}


//// MARK: Limit [Delete]
//func GroupdeleteRequest(userID : String , goalGroupId : String) {
//    let urlString = "http://119.202.103.118:8080/api/user".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//    guard let url = URL(string: "\(urlLink)goalGroup/\(userId)/\(goalGroupId)") else {
//        print("🚨 Invalid URL")
//        return
//    }
//    print("🛑 Valid URL = http://119.202.103.118:8080/api/user")
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "DELETE"
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("🚨 Error: \(error.localizedDescription)")
//        } else if let data = data {
//            do {
//                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print("✅ Delete success: \(response)")
////                NotificationCenter.default.post(name: .addNotification, object: nil)
//            } catch {
//                print("🚨 Error during JSON serialization: \(error.localizedDescription)")
//            }
//        }
//    }
//    task.resume()
//}





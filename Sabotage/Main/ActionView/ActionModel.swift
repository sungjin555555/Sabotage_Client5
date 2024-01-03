//
//  ActionModel.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import Foundation


struct ActionTop : Codable {
    // 이 부분의 변수명들은 불러온 부분과 일치해야 함.
    let data : [ActionDummyDataType]
}



struct ActionDummyDataType: Codable {
    let category: String
    let content: String
}


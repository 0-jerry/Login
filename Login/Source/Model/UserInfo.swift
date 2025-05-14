//
//  UserInfo.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import Foundation

struct UserInfo: Equatable {
    let uuid: UUID
    let email: String
    let password: String
    let nickName: String
    
    init(uuid: UUID = .init(),
         email: String,
         password: String,
         nickName: String) {
        self.uuid = uuid
        self.email = email
        self.password = password
        self.nickName = nickName
    }
}

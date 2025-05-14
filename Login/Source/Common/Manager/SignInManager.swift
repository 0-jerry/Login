//
//  SignInManager.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import Foundation

struct SignInManager {

    private let storage = SignInUserDefault()
    
    
    
}

struct SignInUserDefault {
    private let container: UserDefaults = .standard
    
    private enum Key {
        static let uuid: String = "UUID"
        static let email: String = "email"
        static let password: String = "password"
        static let nickName: String = "NickName"
    }
    
    func set(_ userData: UserInfo) {
        container.set(userData.uuid, forKey: Key.uuid)
        container.set(userData.email, forKey: Key.email)
        container.set(userData.password, forKey: Key.password)
        container.set(userData.nickName, forKey: Key.nickName)
    }
    
    func userDate() -> UserInfo? {
        guard let uuid = container.value(forKey: Key.uuid) as? UUID,
              let email = container.string(forKey: Key.email),
              let password = container.string(forKey: Key.password),
              let nickName = container.string(forKey: Key.nickName) else { return nil }
        
        return UserInfo(uuid: uuid,
                        email: email,
                        password: password,
                        nickName: nickName)
    }
}


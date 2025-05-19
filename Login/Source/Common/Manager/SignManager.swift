//
//  SignInManager.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import Foundation

protocol UserInfoUserDefaultProtocol {
    func set(_ userInfo: UserInfo)
    func current() -> UserInfo?
    func delete()
}

class UserInfoUserDefault: UserInfoUserDefaultProtocol {
    
    static let shared = UserInfoUserDefault()
    
    private init() {}
    
    private enum Key {
        static let uuid: String = "UUID"
        static let email: String = "email"
        static let password: String = "password"
        static let nickName: String = "NickName"
    }
    
    private let container: UserDefaults = .standard
    private var userInfo: UserInfo?
    private var isLogin: Bool {
        self.userInfo != nil
    }
    
    init(container: UserDefaults = .standard) {
        self.container = container
        
        if let uuidString = container.string(forKey: Key.uuid),
           let email = container.string(forKey: Key.email),
           let password = container.string(forKey: Key.password),
           let nickName = container.string(forKey: Key.nickName),
           let uuid = UUID(uuidString: uuidString) {
            self.userInfo =  UserInfo(uuid: uuid,
                                      email: email,
                                      password: password,
                                      nickName: nickName)
        }
        
    }
    
    func set(_ userInfo: UserInfo) {
        self.userInfo = userInfo
        
        let uuidString = userInfo.uuid.uuidString
        container.set(uuidString, forKey: Key.uuid)
        container.set(userInfo.email, forKey: Key.email)
        container.set(userInfo.password, forKey: Key.password)
        container.set(userInfo.nickName, forKey: Key.nickName)
    }
    
    func current() -> UserInfo? {
        guard !isLogin else { return userInfo }
        
        guard let uuidString = container.string(forKey: Key.uuid),
              let email = container.string(forKey: Key.email),
              let password = container.string(forKey: Key.password),
              let nickName = container.string(forKey: Key.nickName),
              let uuid = UUID(uuidString: uuidString) else { return nil }
        
        return UserInfo(uuid: uuid,
                        email: email,
                        password: password,
                        nickName: nickName)
    }
    
    func delete() {
        self.userInfo = nil
        
        container.removeObject(forKey: Key.uuid)
        container.removeObject(forKey: Key.email)
        container.removeObject(forKey: Key.password)
        container.removeObject(forKey: Key.nickName)
    }
}


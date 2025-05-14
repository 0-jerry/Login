//
//  SignInManager.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import Foundation

final class SignManager {

    private let storage: SignInUserDefault
    private let coreDataManager: UserInfoCoreDataManager
    
    static let shared = SignManager()
    
    private init() {
        self.storage = SignInUserDefault()
        self.coreDataManager = UserInfoCoreDataManager()
    }
    
    func signUp(_ userInfo: UserInfo) {
        storage.set(userInfo)
        coreDataManager.create(userInfo)
    }
    
    func current() -> UserInfo? {
        guard let userInfo = storage.userInfo() else { return nil }
        
        let userInfos = coreDataManager.read()
        
        if userInfos.contains(userInfo) {
            return userInfo
        } else {
            return nil
        }
    }
    
    func delete(_ userInfo: UserInfo) {
        storage.delete()
        coreDataManager.delete(userInfo)
    }
}

struct SignInUserDefault {
    private let container: UserDefaults = .standard
    
    private enum Key {
        static let uuid: String = "UUID"
        static let email: String = "email"
        static let password: String = "password"
        static let nickName: String = "NickName"
    }
    

    
    func set(_ userInfo: UserInfo) {
        let uuidString = userInfo.uuid.uuidString
        container.set(uuidString, forKey: Key.uuid)
        container.set(userInfo.email, forKey: Key.email)
        container.set(userInfo.password, forKey: Key.password)
        container.set(userInfo.nickName, forKey: Key.nickName)
    }
    
    func userInfo() -> UserInfo? {
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
        container.removeObject(forKey: Key.uuid)
        container.removeObject(forKey: Key.email)
        container.removeObject(forKey: Key.password)
        container.removeObject(forKey: Key.nickName)
    }
}


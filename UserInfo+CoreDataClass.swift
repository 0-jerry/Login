//
//  UserInfo+CoreDataClass.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//
//

import Foundation
import CoreData

@objc(UserInfoCoreData)
public class UserInfoCoreData: NSManagedObject {
    
    static let classID = "UserInfoCoreData"
    
    enum Key {
        static let email = "email"
        static let password = "password"
        static let nickName = "nickName"
        static let uuid = "uuid"
    }
    
    func userData() -> UserInfo? {
        guard let email = value(forKey: Key.email) as? String,
              let password = value(forKey: Key.password) as? String,
              let nickName = value(forKey: Key.nickName) as? String,
              let uuid = value(forKey: Key.uuid) as? UUID else { return nil }
        
        return UserInfo(uuid: uuid,
                 email: email,
                 password: password,
                 nickName: nickName)
    }
    
    func set(_ userData: UserInfo) {
        setValue(userData.email, forKey: Key.email)
        setValue(userData.password, forKey: Key.password)
        setValue(userData.nickName, forKey: Key.nickName)
        setValue(userData.uuid, forKey: Key.uuid)
    }
}

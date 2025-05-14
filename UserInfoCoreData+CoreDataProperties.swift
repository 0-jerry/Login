//
//  UserInfoCoreData+CoreDataProperties.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//
//

import Foundation
import CoreData

extension UserInfoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfoCoreData> {
        return NSFetchRequest<UserInfoCoreData>(entityName: Self.classID)
    }

    @NSManaged public var email: String?
    @NSManaged public var identifier: UUID?
    @NSManaged public var password: String?
    @NSManaged public var nickName: String?

}

extension UserInfoCoreData: Identifiable {
    
}

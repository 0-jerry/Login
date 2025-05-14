//
//  UserInfoCoreDataManager.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit
import CoreData

struct UserInfoCoreDataManager {
    
    init() {
        self.container = {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil }
            
            return appDelegate.persistentContainer
        }()
        
        self.entity = {
            guard let container = self.container,
                  let entity = NSEntityDescription.entity(forEntityName: UserInfoCoreData.classID, in: container.viewContext) else { return nil }
            
            return entity
        }()
    }
    
    private let container: NSPersistentContainer?
    
    private var entity: NSEntityDescription?
        
    func create(_ userData: UserInfo) {
        guard let entity,
              let container,
              let userInfo = NSManagedObject(entity: entity, insertInto: container.viewContext) as? UserInfoCoreData else { return }
        
        userInfo.set(userData)
        save()
    }
    
    func read() -> [UserInfo] {
        guard let container else { return [] }
        do {
            let results = try container.viewContext.fetch(UserInfoCoreData.fetchRequest())
            let userInfos = results
            
            return userInfos.compactMap { $0.userData() }
        } catch {
            print("불러오기 실패")
            return []
        }
    }
}

extension UserInfoCoreDataManager {

    private func save() {
        guard let container else {
            print("save 실패")
                  return }
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("데이터 저장 실패")
            }
        }
    }
}

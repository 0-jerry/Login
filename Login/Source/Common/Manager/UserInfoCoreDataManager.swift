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
    
    func create(_ userInfo: UserInfo) {
        guard let entity,
              let container,
              let userInfoCoreData = NSManagedObject(entity: entity, insertInto: container.viewContext) as? UserInfoCoreData else { return }
        
        userInfoCoreData.set(userInfo)
        
        save()
    }
    
    func read() -> [UserInfo] {
        let userInfoCoreDatas = fetch()
        let userInfos = userInfoCoreDatas
        
        return userInfos.compactMap { $0.userInfo() }
    }
    
    func delete(_ userInfo: UserInfo) {
        guard let container else { return }
        let userInfoCoreDatas = fetch()
        
        userInfoCoreDatas.forEach {
            if $0.userInfo() == userInfo {
                container.viewContext.delete($0)
            }
        }
        
        save()
    }
}

extension UserInfoCoreDataManager {
    
    private func fetch() -> [UserInfoCoreData] {
        guard let container,
              let userInfoCoreDatas = try? container.viewContext.fetch(UserInfoCoreData.fetchRequest()) else { return [] }
        
        return userInfoCoreDatas
    }
    
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

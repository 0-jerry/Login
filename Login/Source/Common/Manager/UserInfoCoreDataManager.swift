//
//  UserInfoCoreDataManager.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit
import CoreData

enum CoreDataSuccess {
    case create(userInfo: UserInfo)
    case read(userInfos: [UserInfo])
    case delete
}

enum CoreDataError: Error {
    case creat
    case fetch
    case save
    case container
    case unknown(error: Error)
}

protocol UserInfoCoreDataManagerProtocol {
    func create(_ userInfo: UserInfo) throws -> UserInfo
    func read() throws -> [UserInfo]
    func delete(_ userInfo: UserInfo) throws -> UserInfo
}

struct UserInfoCoreDataManager: UserInfoCoreDataManagerProtocol {
    
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
    
    func create(_ userInfo: UserInfo) throws -> UserInfo {
        guard let entity,
              let container else { throw CoreDataError.container }
        
        guard let userInfoCoreData = NSManagedObject(entity: entity,
                                                     insertInto: container.viewContext) as? UserInfoCoreData else {
            throw CoreDataError.creat
        }
        
        userInfoCoreData.set(userInfo)
        try save()
    }
    
    func read() throws -> [UserInfo] {
        let userInfos = try self.fetch().compactMap { $0.userInfo() }
        return userInfos
    }
    
    func delete(_ userInfo: UserInfo) throws -> UserInfo {
        guard let container else {
            throw CoreDataError.container
        }
        
        let userInfoCoreDatas = try self.fetch()
        userInfoCoreDatas.forEach {
            if $0.userInfo() == userInfo {
                container.viewContext.delete($0)
            }
        }
        try save()
    }
}

extension UserInfoCoreDataManager {
    
    private func fetch() throws -> [UserInfoCoreData] {
        guard let container else { throw CoreDataError.container }
        do {
            let userInfoCoreDatas = try container.viewContext
                .fetch(UserInfoCoreData.fetchRequest())
            return userInfoCoreDatas
        } catch {
            throw CoreDataError.fetch
        }
    }
    
    private func save() throws {
        guard let container else { throw CoreDataError.container }
        guard container.viewContext.hasChanges else { return }
        do {
            try container.viewContext.save()
        } catch let error {
            throw CoreDataError.save
        }
        
    }
}

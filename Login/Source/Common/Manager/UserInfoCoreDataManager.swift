//
//  UserInfoCoreDataManager.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit
import CoreData

enum CoreDataSuccess {
    case create
    case read(userInfos: [UserInfo])
    case delete
}

enum CoreDateError: Error {
    case creat
    case read
    case delete
    case save
    case container
    case unknown(error: Error)
}

protocol UserInfoCoreDataManagerProtocol {
    func create(_ userInfo: UserInfo) -> Result<CoreDataSuccess, CoreDateError>
    func read() -> Result<CoreDataSuccess, CoreDateError>
    func delete(_ userInfo: UserInfo) -> Result<CoreDataSuccess, CoreDateError>
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
    
    func create(_ userInfo: UserInfo) -> Result<CoreDataSuccess, CoreDateError> {
        guard let entity,
              let container else { return .failure(.container) }
        
        guard let userInfoCoreData = NSManagedObject(entity: entity,
                                               insertInto: container.viewContext) as? UserInfoCoreData else {
            return .failure(.creat)
        }
        
        userInfoCoreData.set(userInfo)
        
        do {
            try save()
            
            return .success(.create)
        } catch let error as CoreDateError {
            return .failure(error)
        } catch let error {
            return .failure(.unknown(error: error))
        }
    }
    
    func read() -> Result<CoreDataSuccess, CoreDateError> {
        do {
            let userInfos = try self.fetch().compactMap { $0.userInfo() }
            return .success(.read(userInfos: userInfos))
        } catch let error as CoreDateError {
            return .failure(error)
        } catch {
            return .failure(.unknown(error: error))
        }
    }
    
    func delete(_ userInfo: UserInfo) -> Result<CoreDataSuccess, CoreDateError>{
        guard let container else {
            return .failure(.container)
        }
        
        do {
            let userInfoCoreDatas = try self.fetch()
            userInfoCoreDatas.forEach {
                if $0.userInfo() == userInfo {
                    container.viewContext.delete($0)
                }
            }
            try save()
            
            return .success(.delete)
        } catch let error as CoreDateError {
            return .failure(error)
        } catch let error {
            return .failure(.unknown(error: error))
        }
    }
}

extension UserInfoCoreDataManager {
    
    private func fetch() throws -> [UserInfoCoreData] {
        guard let container else { throw CoreDateError.container }
        let userInfoCoreDatas = try container.viewContext
            .fetch(UserInfoCoreData.fetchRequest())
        
        return userInfoCoreDatas
    }
    
    private func save() throws {
        guard let container else { throw CoreDateError.container }
        guard container.viewContext.hasChanges else { return }
        try container.viewContext.save()
    }
}

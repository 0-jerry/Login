//
//  UserInfoRepository.swift
//  Login
//
//  Created by 0-jerry on 5/19/25.
//

import Foundation


protocol UserInfoRepositoryProtocol {
    
    var user: UserInfo? { get }
    
    func signIn(_ email: String, password: String) -> Result<UserInfo, UserInfoError>
    func signUp(_ userInfo: UserInfo) -> Result<UserInfo, UserInfoError>
    func logout() -> Result<UserInfo, UserInfoError>
    func leave() -> Result<UserInfo, UserInfoError>
    
    func emailCheck(_ email: String) -> Result<String, UserInfoError>
    func nickNameCheck(_ nickName: String) -> Result<String, UserInfoError>
}

final class UserInfoRepository: UserInfoRepositoryProtocol {
    
    private let coreDataManager: UserInfoCoreDataManagerProtocol
    private let userDefault: UserInfoUserDefaultProtocol
    
    var user: UserInfo?
    
    init(coreDataManager: UserInfoCoreDataManagerProtocol = UserInfoCoreDataManager(),
         userDefault: UserInfoUserDefaultProtocol = UserInfoUserDefault.shared) {
        self.coreDataManager = coreDataManager
        self.userDefault = userDefault
        self.user = UserInfoUserDefault().current()
    }
    
    func signIn(_ email: String, password: String) -> Result<UserInfo, UserInfoError> {
        let result = Result { try coreDataManager.read() }
            .flatMap { userInfos in
                let userInfos = userInfos.filter { $0.email == email && $0.password == password }
                if let userInfo = userInfos.first {
                    return .success(userInfo)
                } else {
                    return .failure(UserInfoError.signIn(reason: .fail))
                }
            }
            .mapError { error in
                if let userInfoError = error as? UserInfoError {
                    return userInfoError
                } else {
                    return UserInfoError.signIn(reason: .unknown(reason: error)) as UserInfoError
                }
            }
        
        return result
    }
    
    func signUp(_ userInfo: UserInfo) -> Result<UserInfo, UserInfoError> {
        let result = Result { try coreDataManager.create(userInfo) }
            .mapError({ error in
                UserInfoError.signUp(reason: .dataError(reason: error))
            })
        
        return result
    }
    
    func logout() -> Result<UserInfo, UserInfoError> {
        guard let user else { return .failure(.logout(reason: .noUser))}
        return .success(user)
    }
    
    func leave() -> Result<UserInfo, UserInfoError> {
        guard let user else {
            return .failure(.logout(reason: .noUser))
        }
        let result = Result { try coreDataManager.delete(user) }
            .flatMap { userInfo in
                if user == userInfo {
                    userDefault.delete()
                    return .success(userInfo)
                } else {
                    return .failure(UserInfoError.logout(reason: .noUser))
                }
            }
            .mapError { error in
                if let userInfoError = error as? UserInfoError {
                    return userInfoError
                } else {
                    return UserInfoError.leave(reason: .deleteFail)
                }
            }
        
        return result
    }
    
    func emailCheck(_ email: String) -> Result<String, UserInfoError> {
        let result = Result { try coreDataManager.read() }
            .flatMap { userInfos in
                if !userInfos.contains(where: { $0.email == email }) {
                    return .success(email)
                } else {
                    return .failure(UserInfoError.overlap(reason: .email))
                }
            }
            .mapError { error in
                if let userInfoError = error as? UserInfoError {
                    return userInfoError
                } else {
                    return UserInfoError.overlap(reason: .unknown(reason: error))
                }
            }
        
        return result
    }
    
    func nickNameCheck(_ nickName: String) -> Result<String, UserInfoError> {
        let result = Result { try coreDataManager.read() }
            .flatMap { userInfos in
                if !userInfos.contains(where: { $0.nickName == nickName }) {
                    return .success(nickName)
                } else {
                    return .failure(UserInfoError.overlap(reason: .nickName))
                }
            }
            .mapError { error in
                if let userInfoError = error as? UserInfoError {
                    return userInfoError
                } else {
                    return UserInfoError.overlap(reason: .unknown(reason: error))
                }
            }
        
        return result
    }
    
}

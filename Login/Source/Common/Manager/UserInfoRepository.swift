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
        <#code#>
    }
    
    func signUp(_ userInfo: UserInfo) -> Result<UserInfo, UserInfoError> {
        <#code#>
    }
    
    func logout() -> Result<UserInfo, UserInfoError> {
        <#code#>
    }
    
    func leave() -> Result<UserInfo, UserInfoError> {
        <#code#>
    }
    
    func emailCheck(_ email: String) -> Result<String, UserInfoError> {
        <#code#>
    }
    
    func nickNameCheck(_ nickName: String) -> Result<String, UserInfoError> {
        <#code#>
    }
    
    
}

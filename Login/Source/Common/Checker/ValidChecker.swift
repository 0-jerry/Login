//
//  ValidChecker.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

import Foundation

protocol ValidCheckerProtocol {
    func email(_ email: String) -> Result<ValidSuccess, ValidError>
    func password(_ password: String) -> Result<ValidSuccess, ValidError>
    func confirmPassword(_ confirmPassword: String) -> Result<ValidSuccess, ValidError>
    func nickName(_ nickName: String) -> Result<ValidSuccess, ValidError>
}

struct ValidChecker: ValidCheckerProtocol {
    
    init() {
        self.emailEvaluator = EmailEvaluator()
        self.passwordEvaluator = PasswordEvaluator()
        self.nickNameEvaluator = NickNameEvaluator()
    }
    
    private let emailEvaluator: any EmailEvaluatorProtocol
    private let passwordEvaluator: any PasswordEvaluatorProtocol
    private let nickNameEvaluator: any NickNameEvaluatorProtocol
    
    private var password: String? = nil
    
    func email(_ email: String) -> Result<ValidSuccess, ValidError> {
        if let reason = emailEvaluator.reason(email) {
            return .failure(ValidError.email(reason: reason))
        } else {
            return .success(.email)
        }
    }
    
   func password(_ password: String) -> Result<ValidSuccess, ValidError> {
       if let reason = passwordEvaluator.reason(password) {
           return .failure(.password(reason: reason))
       } else {
           return .success(.password)
       }
    }
    
    func confirmPassword(_ confirmPassword: String) -> Result<ValidSuccess, ValidError> {
        guard let password,
              password == confirmPassword else {
            return .failure(.confirmPassword(reason: .notEqual))
        }
        return .success(.passwordConfirm)
    }
    
    func nickName(_ nickName: String) -> Result<ValidSuccess, ValidError> {
        if let reason = nickNameEvaluator.reason(nickName) {
            return .failure(.nickName(reason: reason))
        } else {
            return .success(.nickName)
        }
    }
}

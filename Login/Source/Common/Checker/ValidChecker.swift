//
//  ValidChecker.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

import Foundation

protocol ValidCheckerProtocol {
    func email(_ email: String) -> Result<String, SignUpError>
    func password(_ password: String) -> Result<String, SignUpError>
}

struct ValidChecker: ValidCheckerProtocol {
    static let emailErrorMessage = "영문 소문자로 시작, 8~20자, 올바른 이메일 형식이 필요합니다."
    static let passwortErrorMessage = "8자이상, 대/소문자, 숫자, 특수문자 각 1개 이상 필요 합니다."
    func email(_ email: String) -> Result<String, SignUpError> {
        guard let emailRegex = RegexPattern()
            .characterSet(types: .lowerCase, max: 1)
            .characterSet(types: .lowerCase, .number, min: 7, max: 19)
            .appendCharacter("@")
            .characterSet(types: .lowerCase, .hyphen, .number)
            .addTLD()
            .build() else {
            return .failure(.unknown)
        }
        
        guard let _ = email.range(of: emailRegex, options: .regularExpression) else {
            return .failure(.email(message: Self.emailErrorMessage))
        }
        
        return .success(email)
    }
    
    func password(_ password: String) -> Result<String, SignUpError> {
        guard let passwordRegex = RegexPattern()
            .contains(types: .lowerCase,
                             .upperCase,
                             .number,
                             .specialCharacter)
            .characterSet(types: .lowerCase,
                                 .upperCase,
                                 .number,
                                 .specialCharacter,
                          min: 8)
            .build() else { return .failure(.unknown) }
        
        guard let _ = password.range(of: passwordRegex, options: .regularExpression) else {
            return .failure(.password(message: Self.passwortErrorMessage))
        }
        
        return .success(password)
    }
}


//
//  ValidChecker.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

import Foundation

protocol ValidCheckerProtocol {
    func email(_ email: String) -> Bool
    func password(_ password: String) -> Bool
}

struct ValidChecker: ValidCheckerProtocol {
    static let emailErrorMessage = "영문 소문자로 시작, 8~20자, 올바른 이메일 형식이 필요합니다."
    static let passwortErrorMessage = "8자이상, 대/소문자, 숫자, 특수문자 각 1개 이상 필요 합니다."
    func email(_ email: String) -> Bool {
        guard let emailRegex = RegexPattern()
            .characterSet(types: .lowerCase, max: 1)
            .characterSet(types: .lowerCase, .number, min: 7, max: 19)
            .appendCharacter("@")
            .characterSet(types: .lowerCase, .hyphen, .number)
            .addTLD()
            .build() else {
            return false
        }
        
        guard let _ = email.range(of: emailRegex,
                                  options: .regularExpression) else {
            return false
        }
        //FIXME: - 이메일 중복과 같은 케이스들을 고려해 에러메세지 수정방식을 구현해야함
        guard !UserInfoCoreDataManager()
            .read()
            .contains(where: { $0.email == email}) else {
            return false
        }
        
        return true
    }
    
    func password(_ password: String) -> Bool {
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
            .build() else { return false }
        
        guard let _ = password.range(of: passwordRegex, options: .regularExpression) else {
            return false
        }
        
        return true
    }
}


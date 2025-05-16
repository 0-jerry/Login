//
//  SignUpError.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

enum SignUpError: Error {
    case email(reason: Email)
    case password(reason: PassWord)
    case confirmPassword(reason: ConfirmPassWord)
    case nickName(reason: NickName)
    case other(reason: AnyReason)
    
    enum Email: CustomStringConvertible {
        case overlap
        case startCharacter
        case form
        case length
        
        var description: String {
            switch self {
            case .overlap:
                return "이미 존재하는 이메일입니다."
            case .startCharacter:
                return "아이디는 소문자로 시작해야 합니다."
            case .form:
                return "이메일 형식이 맞지 않습니다."
            case .length:
                return "아이디 길이는 8~20자여야 합니다."
            }
        }
    }
    
    enum PassWord: CustomStringConvertible {
        case upperCase
        case lowerCase
        case number
        case specialCharacter
        case length
        
        var description: String {
            switch self {
            case .upperCase:
                return "대문자를 포함해야합니다."
            case .lowerCase:
                return "소문자를 포함해야합니다."
            case .number:
                return "숫자를 포함해야합니다"
            case .specialCharacter:
                return "특수문자를 포함해야합니다."
            case .length:
                return "길이가 8자 이상이어야 합니다."
            }
        }
    }
    
    enum ConfirmPassWord: CustomStringConvertible {
        case notEqual
        
        var description: String {
            switch self {
            case .notEqual:
                return "비밀번호와 일치하지 않습니다."
            }
        }
    }
    
    enum NickName: CustomStringConvertible {
        case overlap
        case length
        
        var description: String {
            switch self {
            case .overlap:
                return "이미 존재하는 닉네임입니다."
            case .length:
                return "닉네임의 길이는 3~20자여야 합니다"
            }
        }
    }
    
    protocol AnyReason: CustomStringConvertible {}
    
    var errorMessage: String {
        let errorReason: CustomStringConvertible
        
        switch self {
        case .email(reason: let reason):
            errorReason = reason
        case .password(reason: let reason):
            errorReason = reason
        case .confirmPassword(reason: let reason):
            errorReason = reason
        case .nickName(reason: let reason):
            errorReason = reason
        case .other(reason: let reason):
            errorReason = reason
        }
        
        return String(describing: errorReason)
    }
}


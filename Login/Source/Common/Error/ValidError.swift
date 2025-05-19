//
//  SignUpError.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

protocol MessageConvertibleError: Error {
    var errorMessage: String { get }
}

enum ValidError: MessageConvertibleError {
    case email(reason: Email)
    case password(reason: PassWord)
    case confirmPassword(reason: ConfirmPassWord)
    case nickName(reason: NickName)
    case other(reason: AnyReason)
    
    enum Email: CustomStringConvertible {
        case startCharacter
        case form
        case length
        case idform
        
        var description: String {
            switch self {
            case .startCharacter:
                return "아이디는 소문자로 시작해야 합니다."
            case .form:
                return "이메일 형식이 맞지 않습니다."
            case .length:
                return "아이디의 길이는 8~20자여야 합니다."
            case .idform:
                return "아이디는 소문자와 숫자로 이뤄져야 합니다."
            }
        }
    }
    
    enum PassWord: CustomStringConvertible {
        case contains
        case length
        
        var description: String {
            switch self {
            case .contains:
                return "대/소문자, 숫자, 특수문자 각 1개 이상 필요 합니다."
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
        case length
        
        var description: String {
            switch self {
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


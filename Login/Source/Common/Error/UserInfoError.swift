//
//  UserInfoError.swift
//  Login
//
//  Created by 0-jerry on 5/19/25.
//


enum UserInfoError: MessageConvertibleError {
    
    case signIn(reason: SignIn)
    case signUp(reason: SignUp)
    case logout(reason: Logout)
    case leave(reason: Leave)
    case overlap(reason: Overlap)
    
    enum SignIn: CustomStringConvertible {
        case fail
        case readFail
        case already
        case unknown(reason: Error)
        
        var description: String {
            switch self {
            case .fail:
                return "아이디와 비밀번호를 다시 확인해주세요"
            case .readFail:
                return "데이터를 읽어오는데 실패했습니다."
            case .already:
                return "이미 로그인되어 있습니다."
            case .unknown(let error):
                return error.localizedDescription
            }
        }
    }
    
    enum SignUp: CustomStringConvertible {
        case existEmail
        case existNickName
        case dataError(reason: Error)
        
        var description: String {
            switch self {
            case .existEmail:
                return "이미 가입된 이메일입니다."
            case .existNickName:
                return "이미 존재하는 닉네임입니다."
            case .dataError(reason: let reason):
                return reason.localizedDescription
            }
        }
    }
    
    enum Logout: CustomStringConvertible {
        case noUser
        case readFail
        case fail
        case unknown
        
        var description: String {
            switch self {
            case .noUser:
                return "로그인 중인 유저가 없습니다."
            case .readFail:
                return "데이터를 확인하는데 실패했습니다."
            case .fail:
                return "로그아웃에 실패했습니다."
            case .unknown:
                return "알 수 없는 에러"
            }
        }
        
    }
    
    enum Leave: CustomStringConvertible {
        case noUser
        case deleteFail
        case unknown
        
        var description: String {
            switch self {
            case .noUser:
                return "유저를 찾을 수 없습니다."
            case .deleteFail:
                return "데이터를 삭제하는데 실패했습니다."
            case .unknown:
                return "알 수 없는 에러"
            }
        }
    }
    
    enum Overlap: CustomStringConvertible {
        case email
        case nickName
        case unknown(reason: Error)
        
        var description: String {
            switch self {
            case .email:
                return "이미 가입되어있는 이메일입니다."
            case .nickName:
                return "이미 존재하는 닉네임입니다."
            case .unknown(reason: let error):
                return error.localizedDescription
            }
        }
    }
    
    var errorMessage: String {
        
        let errorMessage: String
        switch self {
        case .signIn(reason: let reason):
            errorMessage = String(describing: reason)
        case .signUp(reason: let reason):
            errorMessage = String(describing: reason)
        case .logout(reason: let reason):
            errorMessage = String(describing: reason)
        case .leave(reason: let reason):
            errorMessage = String(describing: reason)
        case .overlap(reason: let reason):
            errorMessage = String(describing: reason)
        }
        
        return errorMessage
    }
    
}

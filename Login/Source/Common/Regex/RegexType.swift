//
//  RegexType.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

enum RegexType: Comparable {
    case upperCase
    case lowerCase
    case number
    case specialCharacter
    case dot
    case hyphen
    
    var rawPattern: String {
        switch self {
        case .upperCase: return "A-Z"
        case .lowerCase: return "a-z"
        case .number: return "0-9"
        case .specialCharacter: return "!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/\\?"
        case .dot: return "."
        case .hyphen: return "-"
        }
    }
}

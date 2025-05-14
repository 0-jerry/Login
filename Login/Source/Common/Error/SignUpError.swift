//
//  SignUpError.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

// TODO: - 이후 세분화 시도?
enum SignUpError: Error {
    case email(message: String)
    case password(message: String)
    case confirmPassword
    case nickName
    case unknown
}

//
//  Mock.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

import Foundation

struct Mock {
    static let emailSuccess = [
        "normalcase1@naver.com",
        "tldcheack@yahoo.co.kr",
        "hypencheck@na-ver.com",
        "maxlengthchecker012@naver.com"
    ]
    
    static let emailFailure = [
        "0numberstart@naver.com",
        "UPPERCASE@naver.com",
        "domainfail@naver",
        "overlengthchecker0123@naver.com"
    ]
    
    static let passwordSuccess = [
        "As!2123123",
        "As!!!!!1!!"
    ]
    
    static let passwordFailure = [
        "asdasdsadasd",
        "asd123asd123",
        "asd aA123!adw",
        "Aa!1"
    ]
}

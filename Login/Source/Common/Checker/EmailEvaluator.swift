//
//  EmailChecker.swift
//  Login
//
//  Created by 0-jerry on 5/16/25.
//

protocol EmailEvaluatorProtocol: Evaluator {
    func reason(_ email: String) -> SignUpError.Email?
}

struct EmailEvaluator: EmailEvaluatorProtocol {
    
    init(container: UserInfoCoreDataManager) {
        self.container = container
    }
    private let container: UserInfoCoreDataManager
    
    func reason(_ email: String) -> SignUpError.Email? {
        guard !isExist(email) else {
            return .exist
        }
        let components = email.components(separatedBy: "@")
        
        guard components.count == 2 else {
            return .form
        }
        
        let id = components[0]
        let domain = components[1]
        
        if let reason = idCheck(id) {
            return reason
        } else if let reason = domainCheck(domain) {
            return reason
        } else { return nil }
    }
    
    private func isExist(_ email: String) -> Bool {
        container.read().contains(where: { $0.email == email })
    }
    
    private func idCheck(_ id: String) -> SignUpError.Email? {
        guard startCharacterValid(id) else {
            return .startCharacter
        }
        
        guard idFormatVaild(id) else {
            return .idform
        }
        
        guard lengthValid(id) else {
            return .length
        }
        
        return nil
    }
    
    private func domainCheck(_ domain: String) -> SignUpError.Email? {
        guard domainFormatValid(domain) else {
            return .form
        }
        
        return nil
    }
    
    private func startCharacterValid(_ id: String) -> Bool {
        let startRegex = RegexPattern()
            .prefix(types: .lowerCase, min: 1)
            .build()
        
        return evaluate(startRegex, with: id)
    }
    
    private func idFormatVaild(_ id: String) -> Bool {
        let idFormatRegexForm = RegexPattern()
            .characterSet(types: .lowerCase, .number)
            .build()
        
        return evaluate(idFormatRegexForm, with: id)
    }
    
    private func lengthValid(_ id: String) -> Bool {
        let lengthRegex = RegexPattern()
            .length(min: 8, max: 20)
            .build()
        
        return evaluate(lengthRegex, with: id)
    }
    
    private func domainFormatValid(_ domain: String) -> Bool {
        let domainRegex = RegexPattern()
            .characterSet(types: .lowerCase, .hyphen, .number)
            .addTLD()
            .build()
        
        return evaluate(domainRegex, with: domain)
    }
}

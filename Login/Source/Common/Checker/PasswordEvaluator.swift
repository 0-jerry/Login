//
//  PasswordChecker.swift
//  Login
//
//  Created by 0-jerry on 5/16/25.
//

protocol PasswordEvaluatorProtocol: Evaluator {
    func reason(_ value: String) -> SignUpError.PassWord?
}

struct PasswordEvaluator: PasswordEvaluatorProtocol {
        
    func reason(_ value: String) -> SignUpError.PassWord? {
        guard contains(value) else { return .contains }
        guard lengthValid(value) else { return .length }
        
        return nil
    }
    
    private func contains(_ password: String) -> Bool {
        let regex = RegexPattern()
            .contains(types: .upperCase, .lowerCase, .number, .specialCharacter)
            .build()
        
        return evaluate(regex, with: password)
    }
    
    private func lengthValid(_ password: String) -> Bool {
        let regex = RegexPattern()
            .length(min: 8, max: 20)
            .build()
        
        return evaluate(regex, with: password)
    }

}

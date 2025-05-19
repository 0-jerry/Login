//
//  NickNameEvaluator.swift
//  Login
//
//  Created by 0-jerry on 5/16/25.
//

protocol NickNameEvaluatorProtocol: Evaluator {
    func reason(_ nickName: String) -> ValidError.NickName?
}

struct NickNameEvaluator: NickNameEvaluatorProtocol {
    
    func reason(_ nickName: String) -> ValidError.NickName? {
        guard lengthValid(nickName) else {
            return .length
        }
        
        return nil
    }
    
    private func lengthValid(_ nickName: String) -> Bool {
        let regex = RegexPattern()
            .length(min: 3, max: 20)
            .build()
        
        return evaluate(regex, with: nickName)
    }
}

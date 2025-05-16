//
//  NickNameEvaluator.swift
//  Login
//
//  Created by 0-jerry on 5/16/25.
//

protocol NickNameEvaluatorProtocol: Evaluator {
    func reason(_ nickName: String) -> SignUpError.NickName?
}

struct NickNameEvaluator: NickNameEvaluatorProtocol {
    
    private let container: UserInfoCoreDataManager
       
    init(container: UserInfoCoreDataManager) {
        self.container = container
    }
    
    func reason(_ nickName: String) -> SignUpError.NickName? {
        guard !isExist(nickName) else {
            return .overlap
        }
        
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
    
    private func isExist(_ nickName: String) -> Bool {
        return container.read().contains(where: { $0.nickName == nickName})
    }
}

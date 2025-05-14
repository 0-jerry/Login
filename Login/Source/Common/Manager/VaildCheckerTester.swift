//
//  VaildCheckerTester.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

struct VaildCheckerSimpleTester {
    private let checker = ValidChecker()
    
    private func emailFailure() {
        
        print("======================\nemailFailure")
        Mock.emailFailure.forEach {
            print(checker.email($0))
        }
        print("======================\n")
    }
    
    private func emailSuccess() {
        
        print("======================\nemailSuccess")
        Mock.emailSuccess.forEach {
            print(checker.email($0))
        }
        print("======================\n")
    }
    
    private func passwordFailure() {
        
        print("======================\npasswordFailure")
        Mock.passwordFailure.forEach {
            print(checker.password($0))
        }
        print("======================\n")
    }

    
    private func passwordSuccess() {
        
        print("======================\npasswordSuccess")
        Mock.passwordSuccess.forEach {
            print(checker.password($0))
        }
        print("======================\n")
    }
    
    func wholeTest() {
        emailFailure()
        emailSuccess()
        passwordFailure()
        passwordSuccess()
    }
}

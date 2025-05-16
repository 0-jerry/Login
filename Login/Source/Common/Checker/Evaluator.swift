//
//  Evaluator.swift
//  Login
//
//  Created by 0-jerry on 5/16/25.
//

import Foundation.NSPredicate

protocol Evaluator {
}

extension Evaluator {
    
    func evaluate(_ regex: String, with string: String) -> Bool {
        return predicate(regex).evaluate(with: string)
    }
    
    private func predicate(_ regex: String) -> NSPredicate {
        return NSPredicate(format: "SELF MATCHES %@", regex)
    }
}


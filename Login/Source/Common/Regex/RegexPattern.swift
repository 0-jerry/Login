//
//  RegexPattern.swift
//  Login
//
//  Created by 0-jerry on 5/14/25.
//

import Foundation

final class RegexPattern {
    
    private static let startMark = "^"
    private static let endMark = "$"
    private static let specialChars = "[](){}.*+?^$|\\"
    private static let containsFormat = "(?=.*[%@])"
    private static let vaildFormat = "[%@]"
    
    private var pattern = ""
    private var containsTypes = Set<RegexType>()
    
    @discardableResult
    func contains(types: RegexType...) -> RegexPattern {
        types.forEach { containsTypes.insert($0) }
        
        return self
    }
    
    @discardableResult
    func characterSet(types: RegexType...,
                               min: Int = 1, max: Int? = nil) -> RegexPattern {
        var validPattern = validForm(Set(types))
        
        if let quantifier = quantifier(min: min, max: max) {
            validPattern += quantifier
        }
        
        pattern += validPattern
        
        return self
    }
    
    @discardableResult
    func appendCharacter(_ char: Character)  -> Self {
        let charString = escapeSpecialCharacter(char)
        pattern += charString
        
        return self
    }
    
    func build() -> String? {
        guard !(pattern.isEmpty && containsTypes.isEmpty) else { return nil }
        
        let containsPattern = containsTypes
            .sorted()
            .map { containsForm($0) }
            .joined()
        
        return Self.startMark + containsPattern + pattern + Self.endMark
    }
    
    private func quantifier(min: Int, max: Int?) -> String? {
        guard let max else {
            switch min {
            case 0:
                return "*"
            case 1:
                return "+"
            default:
                return "{\(min),}"
            }
        }
        
        if max == min {
            return "{\(min)}"
        } else if min < max {
            return "{\(min),\(max)}"
        } else {
            return nil
        }
    }
    
    private func containsForm(_ type: RegexType) -> String {
        String(format: Self.containsFormat, type.rawPattern)
    }
    
    private func validForm(_ types: Set<RegexType>) -> String {
        let validRawPattern = types
            .sorted()
            .map { $0.rawPattern }
            .joined()
        
        return String(format: Self.vaildFormat, validRawPattern)
    }
    
    private func escapeSpecialCharacter(_ char: Character) -> String {
        guard Self.specialChars.contains(char) else {
            return String(char)
        }
        
        return "\\" + String(char)
    }
    
}

extension RegexPattern {
    @discardableResult
    func addTLD() -> RegexPattern {
        pattern += "(\\.[a-z0-9-]+)+"
        
        return self
    }
}

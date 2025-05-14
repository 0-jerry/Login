//
//  UIButton+Extension.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit

extension UIButton {
    
    static func `default`(title: String? = nil) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .System.medium20
        button.setTitleColor(.white.withAlphaComponent(0.2), for: .disabled)
        button.clipsToBounds = true
        
        return button
    }
}

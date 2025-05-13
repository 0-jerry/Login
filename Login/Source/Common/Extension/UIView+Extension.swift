//
//  UIView+Extension.swift
//  Login
//
//  Created by 0-jerry on 5/13/25.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

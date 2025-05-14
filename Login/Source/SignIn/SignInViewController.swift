//
//  SignInViewController.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit

final class SignInViewController: UIViewController {
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        
        label.text = "회원가입 버튼을 눌러주세요."
        label.font = .System.medium20
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton.default(title: "회원가입")
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubViews(guideLabel, signUpButton)
        let safeArea = view.safeAreaLayoutGuide
        
        guideLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guideLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            guideLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 200),
            signUpButton.centerXAnchor.constraint(equalTo: guideLabel.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            signUpButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

@available(iOS 17, *)
#Preview {
    SignInViewController()
}

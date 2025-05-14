//
//  SignUpViewController.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit

final class SignUpViewController: UIViewController {
    private let viewModel = SignUpViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "회원가입"
        label.textColor = .black
        label.font = .System.bold28
        label.textAlignment = .center
        
        return label
    }()
    
    private let emailTextField: SignTextField = {
        let config = SignTextField.Configuration(errorMessage: "영문 소문자로 시작, 8~20자, 올바른 이메일 형식이 필요합니다.",
                                                 placeHolder: "이메일")
        let textField = SignTextField(config)
        
        return textField
    }()
    
    private let passwordTextField: SignTextField = {
        let config = SignTextField.Configuration(errorMessage: "8자이상, 대/소문자, 숫자, 특수문자 각 1개 이상 필요 합니다.",
                                                 placeHolder: "비밀번호")
        let textField = SignTextField(config)
        
        return textField
    }()
    
    private let confirmPasswordTextField: SignTextField = {
        let config = SignTextField.Configuration(errorMessage: "비밀번호가 다릅니다..",
                                                 placeHolder: "비밀번호 확인")
        let textField = SignTextField(config)
        
        return textField
    }()
    
    private let nickNameTextField: SignTextField = {
        let config = SignTextField.Configuration(errorMessage: "닉네임을 입력해주세요.",
                                                 placeHolder: "닉네임")
        let textField = SignTextField(config)
        
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton.default(title: "회원가입")
        
        button.isEnabled = false
        button.setTitleColor(.white.withAlphaComponent(0.2),
                             for: .disabled)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubViews(titleLabel,
                         emailTextField,
                         passwordTextField,
                         confirmPasswordTextField,
                         nickNameTextField,
                         signUpButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
        ])
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
        ])
        
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            nickNameTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            nickNameTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            nickNameTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
        ])

        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 60),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

@available(iOS 17, *)
#Preview {
    SignUpViewController()
}

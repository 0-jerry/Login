//
//  SignUpViewController.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

final class SignUpViewController: UIViewController {
    
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
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
                                                 placeHolder: "비밀번호",
                                                 isSecureTextEntry: true)
        let textField = SignTextField(config)
        
        return textField
    }()
    
    private let confirmPasswordTextField: SignTextField = {
        let config = SignTextField.Configuration(errorMessage: "비밀번호가 다릅니다.",
                                                 placeHolder: "비밀번호 확인",
                                                 isSecureTextEntry: true)
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
        
        bind()
        setupUI()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
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
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
        ])
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
        ])
        
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 32),
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
    
    private func bind() {
        textBind()
        editEndBind()
        responderChangeBind()
        validBind()
        buttonBind()
    }

    private func textBind() {
        emailTextField.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                owner.viewModel.emailRelay.accept(text)
            }).disposed(by: disposeBag)
        
        passwordTextField.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                owner.viewModel.passwordRelay.accept(text)
            }).disposed(by: disposeBag)
        
        confirmPasswordTextField.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                owner.viewModel.confirmPasswordRelay.accept(text)
            }).disposed(by: disposeBag)
        
        nickNameTextField.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                owner.viewModel.nickNameRelay.accept(text)
            }).disposed(by: disposeBag)
    }
    
    private func editEndBind() {
        emailTextField.endEditing
            .drive(with: self, onNext: { owner, _ in
                owner.viewModel.endEdit.accept(.email)
            }).disposed(by: disposeBag)
        
        passwordTextField.endEditing
            .drive(with: self, onNext: { owner, _ in
                owner.viewModel.endEdit.accept(.password)
            }).disposed(by: disposeBag)
        
        confirmPasswordTextField.endEditing
            .drive(with: self, onNext: { owner, _ in
                owner.viewModel.endEdit.accept(.confirmPassword)
            }).disposed(by: disposeBag)
        
        nickNameTextField.endEditing
            .drive(with: self, onNext: { owner, _ in
                owner.viewModel.endEdit.accept(.nickName)
            }).disposed(by: disposeBag)
    }
    
    private func responderChangeBind() {
        emailTextField.exit
            .drive(with: self, onNext: { owner, _ in
                owner.passwordTextField.startEditing.accept(())
            }).disposed(by: disposeBag)
        
        passwordTextField.exit
            .drive(with: self, onNext: { owner, _ in
                owner.confirmPasswordTextField.startEditing.accept(())
            }).disposed(by: disposeBag)
        
        confirmPasswordTextField.exit
            .drive(with: self, onNext: { owner, _ in
                owner.nickNameTextField.startEditing.accept(())
            }).disposed(by: disposeBag)
        
        rx.methodInvoked(#selector(view.touchesBegan)).withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    private func validBind() {
        viewModel.invalid
            .drive(with: self, onNext: { owner, type in
                switch type {
                case .email:
                    owner.emailTextField.invalid.accept(())
                case .password:
                    owner.passwordTextField.invalid.accept(())
                case .confirmPassword:
                    owner.confirmPasswordTextField.invalid.accept(())
                case .nickName:
                    owner.nickNameTextField.invalid.accept(())
                case .unknown:
                    return
                }
            }).disposed(by: disposeBag)
    }
    
    private func buttonBind() {
        viewModel.ready
            .drive(with: self,
                   onNext: { owner, ready in
            owner.signUpButton.isEnabled = ready
        }).disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.create.accept(())
                owner.navigationController?.popViewController(animated: false)
            }).disposed(by: disposeBag)
    }
}

@available(iOS 17, *)
#Preview {
    SignUpViewController()
}

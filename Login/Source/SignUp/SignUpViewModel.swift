//
//  SignUpViewModel.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

enum EditType {
    case email
    case password
    case confirmPassword
    case nickName
}

final class SignUpViewModel {
    
    init() { bind() }
    
    private let signInManager = SignManager.shared
    private let validChecker = ValidChecker()
    private let disposeBag = DisposeBag()
    
    private var readyTypes = Set<EditType>()
    
    let emailRelay = BehaviorRelay<String?>(value: "")
    let passwordRelay = BehaviorRelay<String?>(value: "")
    let confirmPasswordRelay = BehaviorRelay<String?>(value: "")
    let nickNameRelay = BehaviorRelay<String?>(value: "")
    
    private let invalidRelay = PublishRelay<SignUpError>()
    var invalid: Driver<SignUpError> {
        invalidRelay.asDriver(onErrorDriveWith: .empty())
    }
    
    private let readyRelay = PublishRelay<Bool>()
    var ready: Driver<Bool> {
        readyRelay.asDriver(onErrorDriveWith: .empty())
    }
    let endEdit = PublishRelay<EditType>()
    
    private func bind() {
        endEdit.withUnretained(self)
            .subscribe(onNext: { owner, type in
                owner.check(type)
            }).disposed(by: disposeBag)
    }
    
    private func check(_ editType: EditType) {
        switch editType {
        case .email: checkEmail()
        case .password: checkPassword()
        case .confirmPassword: checkConfirmPassword()
        case .nickName: checkNickName()
        }
        
        readyRelay.accept(readyTypes.count == 4)
    }
    
    private func checkEmail() {
        guard let email = emailRelay.value else {
            invalidRelay.accept(.email)
            readyTypes.remove(.email)
            return
        }
        
        if validChecker.email(email) {
            readyTypes.insert(.email)
        } else {
            readyTypes.remove(.email)
        }
    }
    private func checkPassword() {
        guard let password = passwordRelay.value else {
            invalidRelay.accept(.password)
            readyTypes.remove(.password)
            return
        }
        
        if validChecker.password(password) {
            readyTypes.insert(.password)
        } else {
            readyTypes.remove(.password)
        }
    }
    private func checkConfirmPassword() {
        guard let password = passwordRelay.value,
              let confirmPassword = confirmPasswordRelay.value,
              password == confirmPassword else {
            invalidRelay.accept(.confirmPassword)
            readyTypes.remove(.confirmPassword)
            return
        }
        
        readyTypes.insert(.confirmPassword)
    }
    private func checkNickName() {
        guard let nickName = nickNameRelay.value,
              !nickName.isEmpty else {
            invalidRelay.accept(.nickName)
            readyTypes.remove(.nickName)
            return
        }
        readyTypes.insert(.nickName)
    }

}

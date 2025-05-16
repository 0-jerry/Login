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
    private let validChecker = ValidChecker(container: UserInfoCoreDataManager.init())
    private let disposeBag = DisposeBag()
    
    private var readyTypes = Set<EditType>()
    
    let emailRelay = BehaviorRelay<String?>(value: "")
    let passwordRelay = BehaviorRelay<String?>(value: "")
    let confirmPasswordRelay = BehaviorRelay<String?>(value: "")
    let nickNameRelay = BehaviorRelay<String?>(value: "")
    
    private let errorRelay = PublishRelay<SignUpError>()
    var error: Driver<SignUpError> {
        errorRelay.asDriver(onErrorDriveWith: .empty())
    }
    
    private let readyRelay = PublishRelay<Bool>()
    var ready: Driver<Bool> {
        readyRelay.asDriver(onErrorDriveWith: .empty())
    }
    let endEdit = PublishRelay<EditType>()
    let create = PublishRelay<Void>()
    
    private func bind() {
        endEdit.withUnretained(self)
            .subscribe(onNext: { owner, type in
                owner.check(type)
            }).disposed(by: disposeBag)
        
        create.withUnretained(self)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { owner, _ in
                guard let email = owner.emailRelay.value,
                      let password = owner.passwordRelay.value,
                      let nickName = owner.nickNameRelay.value else { return }
                let userInfo = UserInfo(email: email,
                                        password: password,
                                        nickName: nickName)
                
                owner.signInManager.signUp(userInfo)
            }).disposed(by: disposeBag)
    }
    
    private func check(_ editType: EditType) {
        switch editType {
        case .email:
            checkEmail()
        case .password:
            checkPassword()
        case .confirmPassword:
            checkConfirmPassword()
        case .nickName:
            checkNickName()
        }
        
        readyRelay.accept(readyTypes.count == 4)
    }
    //TODO: 에러 체크
    private func checkEmail() {
    }
    private func checkPassword() {
    }
    private func checkConfirmPassword() {
    }
    private func checkNickName() {
    }

}

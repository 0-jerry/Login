//
//  SignInViewModel.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class SignInViewModel {
    private let disposeBag = DisposeBag()
    private let signInManager = SignManager.shared
    let load: PublishRelay<Void> = .init()
    let signInRelay = BehaviorRelay<Bool>(value: false)
    var signIn: Driver<Bool> { signInRelay.asDriver() }
    
    init() { bind() }
    
    func bind() {
        load.withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let current = owner.signInManager.current()
                owner.signInRelay.accept(current != nil)
            }).disposed(by: disposeBag)
    }
}

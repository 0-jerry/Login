//
//  WelcomeViewModel.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class WelcomeViewModel {
    private let signManager = SignManager.shared
    private let disposeBag = DisposeBag()
    private let userInfoRelay: BehaviorRelay<UserInfo?>
    var userInfo: Driver<UserInfo?> {
        userInfoRelay.asDriver()
    }
    let logoutRelay: PublishRelay<Void> = .init()
    let leaveRelay: PublishRelay<Void> = .init()
    
    init() {
        let userInfo = signManager.current()
        self.userInfoRelay = BehaviorRelay<UserInfo?>(value: userInfo)
        bind()
    }
    
    private func bind() {
        logoutRelay.withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.signManager.logout()
            }).disposed(by: disposeBag)
        
        leaveRelay.withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard let userInfo = owner.userInfoRelay.value else { return }
                owner.signManager.delete(userInfo)
            }).disposed(by: disposeBag)
    }
}

//
//  UserViewModel.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel {
    private let getUserUseCase: GetUserUseCase
    private let disposeBag = DisposeBag()

    // Inputs
    let requestSubject = PublishSubject<String>()

    // Outputs
    let user: PublishSubject<User?> = PublishSubject()
    let error: PublishSubject<Error> = PublishSubject()

    init(getUserUseCase: GetUserUseCase) {
        self.getUserUseCase = getUserUseCase
        setupBindings()
    }

    private func setupBindings() {
        requestSubject
            .flatMapLatest { [unowned self] request in
                self.getUserUseCase.execute(request: request)
                    .catch { error in
                        self.error.onNext(error)
                        return Observable.empty()
                    }
            }
            .bind(to: user)
            .disposed(by: disposeBag)
    }

    func fetchUser(userId: String) {
        requestSubject.onNext(userId)
    }
}

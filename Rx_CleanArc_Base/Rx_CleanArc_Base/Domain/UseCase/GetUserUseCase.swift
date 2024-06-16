//
//  GetUserUseCase.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class GetUserUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(request: String) -> Observable<User?> {
        return userRepository.get(byId: request)
    }
}

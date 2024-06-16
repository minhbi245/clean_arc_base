//
//  UserRepositoryImpl.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import Foundation
import RxSwift

class UserRepositoryImpl: UserRepository {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func get(byId id: String) -> Observable<User?> {
        return networkService.fetchUser(userId: id)
    }
}

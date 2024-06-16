//
//  NetworkService.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkService {
    func fetchUser(userId: String) -> Observable<User?> {
        // Implement network request using URLSession or a networking library like Alamofire
        // For simplicity, returning a mock user
        let user = User(id: "012345", name: "John Doe", email: "john.doe@example.com")
        return Observable.just(user)
    }
}



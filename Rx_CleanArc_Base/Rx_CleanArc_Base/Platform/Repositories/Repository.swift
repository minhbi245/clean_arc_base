//
//  Repository.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserRepository {
    func get(byId id: String) -> Observable<User?>
}


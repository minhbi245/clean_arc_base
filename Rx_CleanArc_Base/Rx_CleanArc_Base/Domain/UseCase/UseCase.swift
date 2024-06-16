//
//  UseCase.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol UseCase {
    associatedtype Request
    associatedtype Response

    func execute(request: Request) -> Observable<Response>
}

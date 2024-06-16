//
//  Coordinator.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkService = NetworkService()
        let repository = UserRepositoryImpl(networkService: networkService)
        let useCase = GetUserUseCase(userRepository: repository)
        let viewModel = UserViewModel(getUserUseCase: useCase)
        let viewController = UserViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }

    func navigateToDetail(with user: User) {
        let detailViewModel = DetailViewModel(user: user)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        detailViewController.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
}


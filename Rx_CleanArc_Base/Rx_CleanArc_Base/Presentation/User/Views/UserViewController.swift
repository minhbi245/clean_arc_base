//
//  UserViewController.swift
//  Rx_CleanArc_Base
//
//  Created by khanhnvm-macbook on 16/6/24.
//

import UIKit
import RxSwift
import RxCocoa

class UserViewController: UIViewController {
    // MARK: - Properties
    var coordinator: AppCoordinator?
    private let viewModel: UserViewModel
    private let disposeBag = DisposeBag()

    // MARK: - UI Elements
    private let idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch User", for: .normal)
        return button
    }()

    // MARK: - Initializers
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(requestButton)

        idLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        requestButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),

            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),

            requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40)
        ])
    }

    private func setupBindings() {
        requestButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.fetchUser(userId: "1")
            })
            .disposed(by: disposeBag)

        viewModel.user
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.idLabel.text = "ID: \(user?.id ?? "0")"
                self?.nameLabel.text = "Name: \(user?.name ?? "No data")"
                self?.emailLabel.text = "Email: \(user?.email ?? "No data")"
                if let user = user {
                    self?.coordinator?.navigateToDetail(with: user)
                }
            })
            .disposed(by: disposeBag)

        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                // handle error
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}



//
//  ViewController.swift
//  PLAlertExampleApp
//
//  Created by Peace on 27.08.2022.
//

import UIKit
import PLAlert

final class ViewController: UIViewController, AlertPresentable {
    // MARK: - UI Properties
    private lazy var testOneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ShowDefaultAlert", for: .normal)
        button.addTarget(self, action: #selector(didTapTestOneButton), for: .touchUpInside)
        return button
    }()
    private lazy var testSecondButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ShowAlert With Random Parameters", for: .normal)
        button.addTarget(self, action: #selector(didTapTestSecondButton), for: .touchUpInside)
        return button
    }()
    private lazy var testThirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Inherited Random Parameters Controller", for: .normal)
        button.addTarget(self, action: #selector(didTapTestThirdButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }

}
// MARK: - Action
extension ViewController {
    @objc func didTapTestOneButton() {
        showAlert(type: PLAlertController.self, message: "message")
    }
    @objc func didTapTestSecondButton() {
        showAlert(type: PLAlertController.self, title: "title", message: "message", buttonText: "buttonText", animationConfiguration: .init(animationStartPosition: .bottomRight, animationEndPosition: .bottomLeft, animationPresentDuration: 1, animationDismissalDuration: 1, dimmingViewAlpha: 0.7))
    }
    @objc func didTapTestThirdButton() {
        showAlert(type: InheritedAlertController.self, message: "message")
    }
}
// MARK: - SetupUI
extension ViewController {
    func setupUI() {
        view.addSubview(testOneButton)
        view.addSubview(testSecondButton)
        view.addSubview(testThirdButton)
    }
}
// MARK: - Setup Layout
extension ViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            testOneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            testOneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testOneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testOneButton.heightAnchor.constraint(equalToConstant: 50),
            // second
            testSecondButton.topAnchor.constraint(equalTo: testOneButton.bottomAnchor),
            testSecondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testSecondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testSecondButton.heightAnchor.constraint(equalToConstant: 50),
            // third
            testThirdButton.topAnchor.constraint(equalTo: testSecondButton.bottomAnchor),
            testThirdButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testThirdButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testThirdButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

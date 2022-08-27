//
//  AlertPresentable.swift
//  DadJokeTeller
//
//  Created by Peace on 19.08.2022.
//

import UIKit

public protocol AlertPresentable {
    func showAlert(
        type: PLAlertController.Type,
        title: String,
        message: String,
        buttonText: String,
        animationConfiguration: AnimationConfiguration?
    )
}
// MARK: - Extension
extension AlertPresentable where Self: UIViewController {
    public func showAlert(
        type: PLAlertController.Type,
        title: String = "Alert",
        message: String,
        buttonText: String = "Cancel",
        animationConfiguration: AnimationConfiguration? = .init(
            animationStartPosition: .bottomLeft,
            animationEndPosition: .bottomRight,
            animationPresentDuration: 1,
            animationDismissalDuration: 1
        )
    ) {
        let alertController = type.init(
            title: title,
            text: message,
            buttonText: buttonText,
            animationConfiguration: animationConfiguration
        )
        present(alertController, animated: true)
    }
}

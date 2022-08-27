//
//  InheritedAlertController.swift
//  PLAlertExampleApp
//
//  Created by Peace on 27.08.2022.
//

import UIKit
import PLAlert

final class InheritedAlertController: PLAlertController {
    // MARK: - Init
    public required init(title: String, text: String, buttonText: String, animationConfiguration: AnimationConfiguration?) {
        super.init(title: title, text: text, buttonText: buttonText, animationConfiguration: animationConfiguration)
        buttonHeightRatio = .random(in: 0.11...0.29)
        shadowDirection = .allCases.randomElement()!
        containerCornerRadius = .random(in: 10...35)
        borderWidth = .random(in: 2...5)
        popTitleHeightRatio = .random(in: 0.11...0.29)
        shadowColor = .black
        containerWidthRatio = .random(in: 0.4...1)
        titleBackgroundColor = .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        buttonBackgroundColor = .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        messageBackgroundColor = .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

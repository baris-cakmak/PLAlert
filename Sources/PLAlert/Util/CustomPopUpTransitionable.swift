//
//  CustomPopUpTransitionable.swift
//  DadJokeTeller
//
//  Created by Peace on 18.08.2022.
//

import UIKit

protocol CustomPopUpTransitionable: AnyObject {
    var transitionController: PopUpTransitionController? { get set }
    func setTransitionController(animationConfiguration: AnimationConfiguration)
}
// MARK: - Extension
extension CustomPopUpTransitionable where Self: PLAlertController {
    func setTransitionController(animationConfiguration: AnimationConfiguration) {
        self.transitionController = .init(
            viewController: self,
            viewToBeAnimated: self.containerView,
            animationConfiguration: animationConfiguration
        )
        self.transitioningDelegate = self.transitionController
    }
}

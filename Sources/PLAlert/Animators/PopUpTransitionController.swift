//
//  PopUpTransitionController.swift
//  DadJokeTeller
//
//  Created by Peace on 18.08.2022.
//

import UIKit

final class PopUpTransitionController: NSObject {
    // MARK: - Properties
    private let interactiveTransition: CustomPopUpInteractionController?
    private let viewToBeAnimated: UIView?
    private let animationConfiguration: AnimationConfiguration
    // MARK: - Init
    init(
        viewController: UIViewController,
        viewToBeAnimated: UIView?,
        animationConfiguration: AnimationConfiguration
    ) {
        interactiveTransition = .init(viewController: viewController)
        self.viewToBeAnimated = viewToBeAnimated
        self.animationConfiguration = animationConfiguration
    }
}
// MARK: - UIViewControllerTransitioningDelegate
extension PopUpTransitionController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CustomPopUpAnimator(
            viewToBeAnimated: viewToBeAnimated,
            animationConfiguration: animationConfiguration
        )
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let customPopUpAnimator = CustomPopUpAnimator(
            interactiveController: interactiveTransition,
            viewToBeAnimated: viewToBeAnimated,
            animationConfiguration: animationConfiguration
        )
        customPopUpAnimator.isPresenting = false
        return customPopUpAnimator
    }
    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        guard
            let interactiveController = self.interactiveTransition,
            interactiveController.interactionInProgress else {
            return nil
        }
        return interactiveController
    }
}

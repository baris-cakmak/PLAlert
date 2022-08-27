//
//  CustomPopUpAnimator.swift
//  DadJokeTeller
//
//  Created by Peace on 16.08.2022.
//

import UIKit

public final class CustomPopUpAnimator: NSObject {
    // MARK: - Properties
    var isPresenting = true
    private let interactiveController: CustomPopUpInteractionController?
    private let viewToBeAnimated: UIView?
    private let animationConfiguration: AnimationConfiguration
    // MARK: - Init
    public init(
        interactiveController: CustomPopUpInteractionController? = nil,
        viewToBeAnimated: UIView? = nil,
        animationConfiguration: AnimationConfiguration
    ) {
        self.interactiveController = interactiveController
        self.viewToBeAnimated = viewToBeAnimated
        self.animationConfiguration = animationConfiguration
    }
}
// MARK: - Animate Presentation
extension CustomPopUpAnimator {
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let toVCView = toVC.view,
            let viewToBeAnimated = viewToBeAnimated else {
                return
        }
        let containerView = transitionContext.containerView
        let contrainerFrame = containerView.frame
        let duration = transitionDuration(using: transitionContext)
        containerView.addSubview(toVC.view)
        viewToBeAnimated.isHidden = true
        toVCView.alpha = .zero
        viewToBeAnimated.frame = animationConfiguration
            .animationStartPosition
            .handleAnimationStartPosition(containerFrame: contrainerFrame, viewToBeAnimatedFrame: viewToBeAnimated.frame)
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            usingSpringWithDamping: CustomPopUpAnimatorConstants.presentationDampingRatio,
            initialSpringVelocity: CustomPopUpAnimatorConstants.initialSpringVelocity,
            options: .curveEaseIn,
            animations: {
                viewToBeAnimated.isHidden = false
                toVCView.alpha = 1
                toVCView.backgroundColor = .black.withAlphaComponent(self.animationConfiguration.dimmingViewAlpha)
                viewToBeAnimated.center = containerView.center
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
// MARK: - Animate Dismissal
extension CustomPopUpAnimator {
    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let viewToBeAnimated = viewToBeAnimated else {
                return
        }
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        fromVC.view.backgroundColor = .clear
        containerView.addSubview(fromVC.view)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: .zero,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: .zero,
                    relativeDuration: 1 / 3
                ) {
                    viewToBeAnimated.transform = .init(scaleX: 0.7, y: 0.7)
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 1 / 3,
                    relativeDuration: 2 / 3
                ) {
                    viewToBeAnimated.transform = .init(
                        translationX: -containerView.frame.height / 2,
                        y: .zero
                    )
                    .concatenating(
                        self.animationConfiguration.animationEndPosition.rotateView()
                    )
                    fromVC.view.alpha = .zero
                }
            },
            completion: { _ in
                fromVC.view.backgroundColor = .black.withAlphaComponent(self.animationConfiguration.dimmingViewAlpha)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
// MARK: - UIViewControllerAnimatedTransitioning {
extension CustomPopUpAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        isPresenting ? animationConfiguration.animationPresentDuration : animationConfiguration.animationDismissalDuration
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresenting ? animatePresentation(using: transitionContext) : animateDismissal(using: transitionContext)
    }
}
// MARK: - Constant
extension CustomPopUpAnimator {
    private enum CustomPopUpAnimatorConstants {
        static let presentationDampingRatio: CGFloat = 0.75
        static let initialSpringVelocity: CGFloat = 0.3
    }
}

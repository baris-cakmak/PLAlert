//
//  CustomPopUpInteractionController.swift
//  DadJokeTeller
//
//  Created by Peace on 17.08.2022.
//

import UIKit

public final class CustomPopUpInteractionController: UIPercentDrivenInteractiveTransition {
    // MARK: - Properties
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController?
    // MARK: - Init
    public init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
}
// MARK: - Helper
extension CustomPopUpInteractionController {
    private func prepareGestureRecognizer(in view: UIView) {
        let panGestureRecognizer: UIPanGestureRecognizer = .init(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(panGestureRecognizer)
    }
}
// MARK: - Action
extension CustomPopUpInteractionController {
    @objc private func handleGesture(gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }
        let translation = gesture.translation(in: view)
        let percantage = translation.y / (view.frame.height / 4)
        switch gesture.state {
        case .began:
            interactionInProgress = true
            viewController?.dismiss(animated: true)
            
        case .changed:
            shouldCompleteTransition = percantage > Constants.half
            update(percantage)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
            
        default:
            break
        }
    }
}

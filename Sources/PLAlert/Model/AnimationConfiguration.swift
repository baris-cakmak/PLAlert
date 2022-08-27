//
//  AnimationConfiguration.swift
//  
//
//  Created by Peace on 25.08.2022.
//

import UIKit

public struct AnimationConfiguration {
    // MARK: - Properties
    let animationStartPosition: StartAnimationDirection
    let animationEndPosition: EndAnimationDirection
    let animationPresentDuration: CGFloat
    let animationDismissalDuration: CGFloat
    let dimmingViewAlpha: CGFloat
    // MARK: - Init
    public init(
        animationStartPosition: StartAnimationDirection,
        animationEndPosition: EndAnimationDirection,
        animationPresentDuration: CGFloat = 1,
        animationDismissalDuration: CGFloat = 1,
        dimmingViewAlpha: CGFloat = 0.7
    ) {
        self.animationStartPosition = animationStartPosition
        self.animationEndPosition = animationEndPosition
        self.animationPresentDuration = animationPresentDuration
        self.animationDismissalDuration = animationDismissalDuration
        self.dimmingViewAlpha = dimmingViewAlpha
    }
}

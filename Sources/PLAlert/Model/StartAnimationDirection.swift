//
//  AnimationDirection.swift
//  
//
//  Created by Peace on 24.08.2022.
//

import UIKit

public enum StartAnimationDirection: CaseIterable {
    case bottom
    case bottomLeft
    case bottomRight
    case top
    case topLeft
    case topRight
    // MARK: - Method
    func handleAnimationStartPosition(
        containerFrame: CGRect,
        viewToBeAnimatedFrame: CGRect
    ) -> CGRect {
        switch self {
        case .bottom:
            return .init(
                origin: .init(
                    x: containerFrame.midX,
                    y: containerFrame.maxY
                ),
                size: viewToBeAnimatedFrame.size
            )
        case .bottomLeft:
            return .init(
                origin: .init(
                    x: containerFrame.minX,
                    y: containerFrame.maxY
                ),
                size: viewToBeAnimatedFrame.size
            )
        case .bottomRight:
            return .init(
                origin: .init(
                    x: containerFrame.maxX,
                    y: containerFrame.maxY
                ),
                size: viewToBeAnimatedFrame.size
            )
        case .top:
            return .init(
                origin: .init(
                    x: containerFrame.midX,
                    y: containerFrame.minY
                ),
                size: viewToBeAnimatedFrame.size
            )
        case .topLeft:
            return .init(
                origin: .init(
                    x: containerFrame.minX,
                    y: containerFrame.minY
                ),
                size: viewToBeAnimatedFrame.size
            )
        case .topRight:
            return .init(
                origin: .init(
                    x: containerFrame.maxX,
                    y: containerFrame.minY
                ),
                size: viewToBeAnimatedFrame.size
            )
        }
    }
}

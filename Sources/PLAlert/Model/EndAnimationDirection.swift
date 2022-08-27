//
//  EndAnimationDirection.swift
//  
//
//  Created by Peace on 25.08.2022.
//

import UIKit

public enum EndAnimationDirection: CaseIterable {
    case bottomLeft
    case bottomRight
    
    func rotateView() -> CGAffineTransform {
        switch self {
        case .bottomLeft:
            return .init(rotationAngle: -.pi / 4)
        case .bottomRight:
            return .init(rotationAngle: 5 * .pi / 4)
        }
    }
}

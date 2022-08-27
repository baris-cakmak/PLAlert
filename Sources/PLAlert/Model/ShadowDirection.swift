//
//  ShadowDirection.swift
//  
//
//  Created by Peace on 24.08.2022.
//

import UIKit

public enum ShadowDirection {
    case none
    case top(percentage: CGFloat)
    case bottom(percentage: CGFloat)
    case left(percentage: CGFloat)
    case right(percentage: CGFloat)
    case bottomRight(percentage: CGFloat)
    case bottomLeft(percentage: CGFloat)
    case all
    // MARK: - Method
    func addShadow(coreLayer: inout CAShapeLayer) {
        switch self {

        case .top(let percentage):
            coreLayer.shadowOffset = .init(width: .zero, height: -ShadowDirectionConstants.maximumShadowHeight * percentage)
       
        case .bottom(let percentage):
            coreLayer.shadowOffset = .init(width: .zero, height: ShadowDirectionConstants.maximumShadowHeight * percentage)
        
        case .left(let percentage):
            coreLayer.shadowOffset = .init(width: -ShadowDirectionConstants.maximumShadowHeight * percentage, height: .zero)
        
        case .right(let percentage):
            coreLayer.shadowOffset = .init(width: ShadowDirectionConstants.maximumShadowHeight * percentage, height: .zero)

        case .bottomRight(let percentage):
            coreLayer.shadowOffset = .init(width: ShadowDirectionConstants.maximumShadowHeight * percentage, height: ShadowDirectionConstants.maximumShadowHeight * percentage)
            
        case .bottomLeft(let percentage):
            coreLayer.shadowOffset = .init(width: -ShadowDirectionConstants.maximumShadowHeight * percentage, height: ShadowDirectionConstants.maximumShadowHeight * percentage)
        
        case .all:
            coreLayer.shadowRadius = ShadowDirectionConstants.maximumShadowHeight
            
        case .none:
            coreLayer.shadowRadius = .zero
            coreLayer.shadowColor = UIColor.clear.cgColor
            coreLayer.shadowOpacity = .zero
        }
    }
}
// MARK: - ShadowDirectionConstants
extension ShadowDirection {
    enum ShadowDirectionConstants {
        static let maximumShadowHeight: CGFloat = 20
    }
}
// MARK: - Case Iterable
extension ShadowDirection: CaseIterable {
    public static var allCases: [ShadowDirection] {
        [
            .none,
            .top(percentage: .random(in: 0...1)),
            .bottom(percentage: .random(in: 0...1)),
            .bottomLeft(percentage: .random(in: 0...1)),
            .bottomRight(percentage: .random(in: 0...1)),
            .left(percentage: .random(in: 0...1)),
            .right(percentage: .random(in: 0...1)),
            all
        ]
    }

}

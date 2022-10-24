//
//  BrownianMotionGenerator.swift
//  CGApp
//
//  Created by Matviy Suk on 01.10.2022.
//

import Foundation
import GameplayKit

final class BrownianMotionGenerator {
    // MARK: - Properties
    
    private let rect: CGRect
    

    // MARK: - Init
    
    init(rect: CGRect) {
        self.rect = rect
    }
    
    
    // MARK: - Actions
    
    func fractalPoints(iterations: Int) -> [CGPoint] {
        let random = GKRandomSource()
        let padding: CGFloat = 5
        var points = [CGPoint(x: rect.midX, y: rect.midY)]
        
        for _ in .zero..<iterations {
            let xDisp = GKGaussianDistribution(
                randomSource: random,
                lowestValue: -Int(rect.width / 4),
                highestValue: Int(rect.width / 4)
            ).nextInt()
            let yDisp = GKGaussianDistribution(
                randomSource: random,
                lowestValue: -Int(rect.height / 4),
                highestValue: Int(rect.height / 4)
            ).nextInt()
            
            if let last = points.last {
                points.append(
                    CGPoint(
                        x: last.x.applyDisp(
                            CGFloat(xDisp),
                            min: rect.minX + padding,
                            max: rect.maxX - padding
                        ),
                        y: last.y.applyDisp(
                            CGFloat(yDisp),
                            min: rect.minY + padding,
                            max: rect.maxY - padding
                        )
                    )
                )
            }
        }
        
        return points
    }
}

fileprivate extension CGFloat {
    func applyDisp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        let result = self + value
        
        return result > max ? max : ( result < min ? min : result)
    }
}

//
//  BrownianMotionView.swift
//  CGApp
//
//  Created by Matviy Suk on 01.10.2022.
//

import UIKit

final class BrownianMotionView: FractalView {
    // MARK: - Properties
    private let circleRadius: CGFloat = 3
    private let color: UIColor
    
    private var points = [CGPoint]()


    // MARK: - Init
    init(color: CGColor) {
        self.color = UIColor(cgColor: color)

        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if showFractal {
            if let first = points.first {
                let path = UIBezierPath(
                    arcCenter: first,
                    radius: circleRadius,
                    startAngle: .zero,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true
                )
                
                color.set()
                path.fill()
            }
            
            for i in 1..<points.count {
                let path = UIBezierPath()
                
                path.move(to: points[i - 1])
                path.addLine(to: points[i])
                path.addArc(withCenter: points[i],
                            radius: circleRadius,
                            startAngle: .zero,
                            endAngle: CGFloat.pi * 2,
                            clockwise: true
                )

                color.set()
                path.fill()
            }
        }
    }
    
    // MARK: - Actions
    
    func updatePoints(_ points: [CGPoint]) {
        self.points = points
    }
}

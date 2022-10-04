//
//  PlasmaFractalView.swift
//  CGApp
//
//  Created by Matviy Suk on 01.10.2022.
//

import UIKit

final class PlasmaView: FractalView {
    //MARK: - Properties
    private let color: UIColor
    private let plasmaModifier: PlasmaModifier
    private var points = [[CGFloat]]()
    
    
    // MARK: - Init
    init(color: CGColor, plasmaModifier: PlasmaModifier) {
        self.color = UIColor(cgColor: color)
        self.plasmaModifier = plasmaModifier

        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let calculateColor: ((CGFloat) -> UIColor) = plasmaModifier == .Hue
        ? calculateColorByHue
        : calculateColorBySat
            
        
                
        if showFractal {
            for i in .zero..<points.count {
                for j in .zero..<points[i].count {
                    let color = calculateColor(points[i][j])
                    let path = UIBezierPath(rect: .init(x: i, y: j, width: 1, height: 1))
                    
                    color.set()
                    path.fill()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func calculateColorByHue(_ hue: CGFloat) -> UIColor {
        UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
    private func calculateColorBySat(_ sat: CGFloat) -> UIColor {
        UIColor(hue: color.hue, saturation: sat, brightness: 1.0, alpha: 1.0)
    }
    
    func updatePoints(_ points: [[CGFloat]]) {
        self.points = points
    }
}

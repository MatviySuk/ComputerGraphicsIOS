//
//  PlasmaFractalView.swift
//  CGApp
//
//  Created by Matviy Suk on 01.10.2022.
//

import UIKit
import SnapKit

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
                
        if showFractal {
            let start = DispatchTime.now()

            let width = points.count
            let height = points.first?.count ?? .zero
            let calculateColor: ((CGFloat) -> UIColor) = plasmaModifier == .Hue
            ? calculateColorByHue
            : calculateColorBySat
            
            var bitmap = [PixelData]()

            for i in .zero..<height {
                for j in .zero..<width {
                    bitmap.append(calculateColor(points[j][i]).pixelData)
                }
            }
            
            if let image = CGImage.generateFromBitmap(bitmap, width: width, height: height) {
                layer.contents = image
                fractalImage = UIImage(cgImage: image)
            }
                    
            let end = DispatchTime.now()
            
            print("Plasma Time: \((end.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000)")
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

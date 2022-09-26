//
//  PlasmaGenerator.swift
//  CGApp
//
//  Created by Matviy Suk on 24.09.2022.
//

import Foundation
import UIKit

final class PlasmaGenerator {
    
    // MARK: - Types
    
    struct Point {
        var x: Int
        var y: Int
        
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
        
        init(x: CGFloat, y: CGFloat) {
            self.x = Int(x)
            self.y = Int(y)
        }
        
        func midpointWith(_ point: Point) -> Point {
            Point(
                x: (self.x + point.x) / 2,
                y: (self.y + point.y) / 2
            )
        }
    }
    
    // MARK: - Properties
    
    private let rect: CGRect
    private var roughness: Double = 0.5
    
    private(set) var pointsColors: [[UIColor]]
    
    
    // MARK: - Init
    init(rect: CGRect) {
        self.rect = rect
        
        self.pointsColors = Array(repeating: Array(
            repeating: .white,
            count: Int(rect.height) + 1
        ), count: Int(rect.width) + 1
        )
        
        var colours = [UIColor.blue, .blue, .yellow, .blue].shuffled()
        
        saveColor(.white, at: rect.c1)
        saveColor(.blue, at: rect.c2)
        saveColor(.green, at: rect.c3)
        saveColor(.blue, at: rect.c4)
    }
    
    // MARK: - Actions
    
    func plasmaFractal(roughness: Double) -> [[UIColor]] {
        self.roughness = roughness
        
        midpointDisp(
            rect: rect,
            std: rect.height + rect.width / 2
        )
        
        return pointsColors
    }
    
    private func midpointDisp(
        rect: CGRect,
        std: Double
    ) {
        if rect.width > 1 || rect.height > 1 {
            /*
            let wDisp = Double.random(in: -(rect.width / 4)...(rect.width / 4))
            let hDisp = Double.random(in: -(rect.height / 4)...(rect.height / 4))
            let dispMid = applyDisplacementTo(rect.mid, in: rect, wDisp: wDisp, hDisp: hDisp)
            let e1Disp = applyDisplacementTo(rect.e1, in: rect, wDisp: wDisp)
            let e2Disp = applyDisplacementTo(rect.e2, in: rect, hDisp: hDisp)
            let e3Disp = applyDisplacementTo(rect.e3, in: rect, wDisp: wDisp)
            let e4Disp = applyDisplacementTo(rect.e4, in: rect, hDisp: hDisp)
            
            saveColor(
                getColorBy(rect.c1).getAverageColorWith(getColorBy(rect.c2)),
                at: e1Disp
            )
            saveColor(
                getColorBy(rect.c2).getAverageColorWith(getColorBy(rect.c3)),
                at: e2Disp
            )
            saveColor(
                getColorBy(rect.c3).getAverageColorWith(getColorBy(rect.c4)),
                at: e3Disp
            )
            saveColor(
                getColorBy(rect.c4).getAverageColorWith(getColorBy(rect.c1)),
                at: e4Disp
            )
            saveColor(
                getColorBy(e1Disp).getAverageColorWith(getColorBy(e3Disp)),
                at: dispMid
            )
            
            midpointDisp(rect: CGRect(c1: rect.c1, c2: e1Disp, c3: dispMid), std: std / 2) // Upper-left
            midpointDisp(rect: CGRect(c1: e1Disp, c2: rect.c2, c3: e2Disp), std: std / 2) // Upper-right
            midpointDisp(rect: CGRect(c1: dispMid, c2: e2Disp, c3: rect.c3), std: std / 2) // Lower-right
            midpointDisp(rect: CGRect(c1: e4Disp, c2: dispMid, c3: e3Disp), std: std / 2) // Lower-left
            */

            saveColor(
                getColorBy(rect.c1).getAverageColorWith(getColorBy(rect.c2)),
                at: rect.e1
            )
            saveColor(
                getColorBy(rect.c2).getAverageColorWith(getColorBy(rect.c3)),
                at: rect.e2
            )
            saveColor(
                getColorBy(rect.c3).getAverageColorWith(getColorBy(rect.c4)),
                at: rect.e3
            )
            saveColor(
                getColorBy(rect.c4).getAverageColorWith(getColorBy(rect.c1)),
                at: rect.e4
            )
            saveColor(
                getColorBy(rect.e1).getAverageColorWith(getColorBy(rect.e3)),
                at: rect.mid
            )

            midpointDisp(rect: CGRect(c1: rect.c1, c2: rect.e1, c3: rect.mid), std: std / 2) // Upper-left
            midpointDisp(rect: CGRect(c1: rect.e1, c2: rect.c2, c3: rect.e2), std: std / 2) // Upper-right
            midpointDisp(rect: CGRect(c1: rect.mid, c2: rect.e2, c3: rect.c3), std: std / 2) // Lower-right
            midpointDisp(rect: CGRect(c1: rect.e4, c2: rect.mid, c3: rect.e3), std: std / 2)
        }
    }
    
    private func saveColor(_ color: UIColor, at point: Point) {
        pointsColors[point.x][point.y] = color
    }
    
    private func getColorBy(_ point: Point) -> UIColor {
        pointsColors[point.x][point.y]
    }
    
    private func applyDisplacementTo(_ point: Point, in rect: CGRect, wDisp: Double = .zero, hDisp: Double = .zero) -> Point {
        let x = Double(point.x) + (rect.width > 10 ? wDisp : .zero)
        let y = Double(point.y) + (rect.height > 10 ? hDisp : .zero)
        
        return Point(
            x: x >= rect.maxX ? rect.maxX : (x <= rect.minX ? rect.minX : x),
            y: y >= rect.maxY ? rect.maxY : (y <= rect.minY ? rect.minY : y)
        )
    }
}

fileprivate extension CGRect {
    typealias Point = PlasmaGenerator.Point
    
    /*
     
    c1     e1     c2
    + ---- * ---- +
    |             |
    |     mid     |
 e4 *      @      * e2
    |     mid     |
    |             |
    + ---- * ---- +
    c4     e3     c3
     
    */
        
    var c1: Point {
        Point(x: minX, y: minY)
    }
    
    var c2: Point {
        Point(x: maxX, y: minY)
    }
    
    var c3: Point {
        Point(x: maxX, y: maxY)
    }
    
    var c4: Point {
        Point(x: minX, y: maxY)
    }
    
    var mid: Point {
        Point(x: midX, y: midY)
    }
    
    var e1: Point {
        c1.midpointWith(c2)
    }
    
    var e2: Point {
        c2.midpointWith(c3)
    }
    
    var e3: Point {
        c3.midpointWith(c4)
    }
    
    var e4: Point {
        c4.midpointWith(c1)
    }
    
    init(c1: Point, c2: Point, c3: Point) {
        let width = fabs(Double(c2.x) - Double(c1.x))
        let height = fabs(Double(c3.y) - Double(c2.y))
        
        if width <= 0 || height <= 0 {
            print("Point Stop\(width) \(height)")
        }
        
        self.init(
            origin: CGPoint(x: c1.x, y: c1.y),
            size: CGSize(
                width: width > 0 ? width : 1 ,
                height: height > 0 ? height : 1
            )
        )
    }
}

extension UIColor {
    static var lightCloud: UIColor {
        .init(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0)
    }
    
    static var darkCloud: UIColor {
        .init(red: 0.7, green: 0.7, blue: 1.0, alpha: 1.0)
    }
}

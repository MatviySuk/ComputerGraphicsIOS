//
//  PlasmaGenerator.swift
//  CGApp
//
//  Created by Matviy Suk on 24.09.2022.
//

import GameplayKit
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
    
    private(set) var pointsMap: [[CGFloat]]
    
    
    // MARK: - Init
    init(rect: CGRect) {
        self.rect = rect
        
        self.pointsMap = Array(
            repeating: Array(
                repeating: .zero,
                count: Int(rect.height) + 1
            ),
            count: Int(rect.width) + 1
        )
                
        save(.random(in: .zero...1.0), at: rect.c1)
        save(.random(in: .zero...1.0), at: rect.c2)
        save(.random(in: .zero...1.0), at: rect.c3)
        save(.random(in: .zero...1.0), at: rect.c4)
    }
    
    // MARK: - Actions
    
    func plasmaFractal(roughness: Double) -> [[CGFloat]] {
        self.roughness = roughness
        
        midpointDisp(
            rect: rect,
            std: 1.0
        )
        
        return pointsMap
    }
    
    private func midpointDisp(
        rect: CGRect,
        std: CGFloat
    ) {
        if rect.width > 2 || rect.height > 2 {
/*
//    Firstly, tried to use Gaussian Distribution to generate random number as
//    it was recommended in the source. However, usual random generation gives better result.
            let random = GKRandomSource()
            let gaussDistr = GKGaussianDistribution(randomSource: random, lowestValue: -Int(std * 100), highestValue: Int(std * 100)).nextInt()
 */
            
            let disp = CGFloat.random(in: -std...std) * roughness
            
            save([getValueBy(rect.c1),
                  getValueBy(rect.c2)
                 ].avrg(),
                 at: rect.e1
            )
            
            save([getValueBy(rect.c2),
                  getValueBy(rect.c3)
                 ].avrg(),
                 at: rect.e2
            )
            
            save([getValueBy(rect.c3),
                  getValueBy(rect.c4)
                 ].avrg(),
                 at: rect.e3
            )
            
            save(
                [getValueBy(rect.c1),
                 getValueBy(rect.c4)
                ].avrg(),
                at: rect.e4
            )
            
            save([getValueBy(rect.c1),
                  getValueBy(rect.c2),
                  getValueBy(rect.c3),
                  getValueBy(rect.c4)
                  ].avrg() + disp,
                 at: rect.mid
            )

            midpointDisp(rect: rect.a1, std: std / 2) // Upper-left
            midpointDisp(rect: rect.a2, std: std / 2) // Upper-right
            midpointDisp(rect: rect.a3, std: std / 2) // Lower-right
            midpointDisp(rect: rect.a4, std: std / 2) // Lower-left
        }
        else {
            if (rect.width == 2) {
                pointsMap[rect.c1.x + 1][rect.c1.y] = [getValueBy(rect.c1), getValueBy(rect.c2)].avrg()
            }

            if (rect.height == 2) {
                pointsMap[rect.c1.x][rect.c1.y + 1] = [getValueBy(rect.c1), getValueBy(rect.c4)].avrg()
            }

            if (rect.width == 2 && rect.height == 2) {
                pointsMap[rect.c1.x + 1][rect.c1.y + 1] = [getValueBy(rect.c2), getValueBy(rect.c4)].avrg()
            }
        }
    }
    
    private func save(_ value: CGFloat, at point: Point) {
        pointsMap[point.x][point.y] = value
    }
    
    private func getValueBy(_ point: Point) -> CGFloat {
        pointsMap[point.x][point.y]
    }
}

fileprivate extension CGRect {
    typealias Point = PlasmaGenerator.Point
    
    /*
     
    c1       e1       c2
    + ------ * ------ +
    |        |        |
    |   a1   |   a2   |
    |        |        |
 e4 *-------mid-------* e2
    |        |        |
    |   a4   |   a3   |
    |        |        |
    + ------ * ------ +
    c4       e3       c3
     
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
    
    var a1: CGRect {
        .init(x: c1.x, y: c1.y, width: mid.x - c1.x, height: mid.y - c1.y)
    }
    
    var a2: CGRect {
        .init(x: e1.x, y: e1.y, width: e2.x - e1.x, height: e2.y - e1.y)
    }
    
    var a3: CGRect {
        .init(x: mid.x, y: mid.y, width: c3.x - mid.x, height: c3.y - mid.y)
    }
    
    var a4: CGRect {
        .init(x: e4.x, y: e4.y, width: e3.x - e4.x, height: e3.y - e4.y)
    }
}

fileprivate extension Array where Element == CGFloat {
    func avrg() -> CGFloat {
        self.reduce(.zero, +) / CGFloat(self.count)
    }
}

fileprivate extension CGFloat {
    // func frame() Makes the value to be between 0.0 and 1.0
    func frame() -> CGFloat {
        self < .zero ? .zero : (self > 1.0 ? 1.0 : self)
    }
}

//* * * * * * * * * *

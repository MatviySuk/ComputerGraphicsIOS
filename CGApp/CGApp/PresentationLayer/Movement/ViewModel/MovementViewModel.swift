//
//  MovementViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 12.11.2022.
//

import UIKit

final class MovementViewModel: ObservableObject {
    // MARK: - Properties
    @Published var presentAlert = false
    @Published var stepByXY: Double = 1.0
    @Published var rotationAngle: Double = 30.0
    @Published var startPoints: [Point] = [
        .init(x: .zero, y: 2, name: "A"),
        .init(x: 2, y: .zero, name: "B"),
        .init(x: 2.0, y: 2.0, name: "C")
    ] {
        didSet {
            modifiedPoints = startPoints
        }
    }
    
    @Published var modifiedPoints: [Point] = []
    
    var points: [Point] {
        modifiedPoints + [modifiedPoints.first].compactMap { $0 }
    }
    
    var limitPoints: [Point] {
        [
            .init(x: -10, y: -10),
            .init(x: 10, y: 10)
        ]
    }
    
    
    let pointRange = -5.0...5.0
    let pointStep = 0.5
    
    // MARK: - Init
    
    init() {
        modifiedPoints = startPoints
    }
    
    // MARK: - Actions
    
    func resetPoints() {
        modifiedPoints = startPoints
    }
    
    func getOffsetFor(_ point: Point) -> CGSize {
        if let point = modifiedPoints.first(where: { $0 == point }) {
            let center = getCenter()
            
            let size = CGSize(
                width: point.x < center.x ? 1 : -1,
                height: point.y < center.y ? 8 : -8
            )
            
            return size
        }
        
        return .zero
    }
    
    func applyMovement() {
        let degree = rotationAngle * Double.pi / 180.0
        let posAdd = [stepByXY, stepByXY]
        let rotationMatrix = [
            [cos(degree), sin(degree)],
            [-sin(degree), cos(degree)]
        ]
        
        do {
            let rotatedMatrix = try multiplyMatrixs(
                m1: getPointsMatrix().flatMap { try sumMatrixs(
                    m1: [$0],
                    m2: [posAdd]
                )},
                m2: rotationMatrix
            )
            
            setPointsFrom(matrix: rotatedMatrix)
        } catch {
            print(error)
        }
    }
    
    private func getPointsMatrix() -> [[Double]] {
        modifiedPoints.map { [$0.x, $0.y] }
    }
    
    private func setPointsFrom(matrix: [[Double]]) {
        matrix.enumerated().forEach { index, point in
            modifiedPoints[index].x = point.first!
            modifiedPoints[index].y = point.last!
        }
    }
    
    private func multiplyMatrixs(m1: [[Double]], m2: [[Double]]) throws -> [[Double]] {
        if m1.first?.count == m2.count {
            let m = m1.count
            let p = m2.first?.count ?? .zero
            let n = m1.first?.count ?? .zero
            
            var mtr = Array(repeating: Array(repeating: Double.zero, count: p), count: m)
            
            for i in .zero..<m {
                for j in .zero..<p {
                    var c_ij = Double.zero
                    
                    for k in .zero..<n {
                        c_ij += m1[i][k] * m2[k][j]
                    }
                    
                    mtr[i][j] = c_ij
                }
            }
            
            return mtr
        }
        
        throw StringError(description: "Matrixs cannot be multiplied")
    }
    
    private func sumMatrixs(m1: [[Double]], m2: [[Double]]) throws -> [[Double]] {
        if m1.count == m2.count,
           m1.first?.count == m2.first?.count {
            let n = m1.count
            let m = m1.first?.count ?? .zero
            
            var mtr = Array(repeating: Array(repeating: Double.zero, count: m), count: n)
            
            for i in .zero..<n {
                for j in .zero..<m {
                    mtr[i][j] = m1[i][j] + m2[i][j]
                }
            }
            
            return mtr
        }
        
        throw StringError(description: "Matrixs cannot be added")
    }

    private func getCenter() -> Point {
        let count = Double(modifiedPoints.count)
        
        return Point(
            x: modifiedPoints.map { $0.x }.reduce(0.0, +) / count,
            y: modifiedPoints.map { $0.y }.reduce(0.0, +) / count,
            name: "Center"
        )
    }
    
    func isPointsTriangle() -> Bool {
        let a2 = lenghtSquare(startPoints[1], startPoints[2])
        let b2 = lenghtSquare(startPoints[0], startPoints[2])
        let c2 = lenghtSquare(startPoints[0], startPoints[1])
        
        let a = sqrt(a2)
        let b = sqrt(b2)
        let c = sqrt(c2)
        
        // From Cosine law
        var alpha = acos((b2 + c2 - a2)/(2*b*c))
        var betta = acos((a2 + c2 - b2)/(2*a*c))
        var gamma = acos((a2 + b2 - c2)/(2*a*b))
        
        // Converting to degree
        alpha = (alpha * 180 / Double.pi)
        betta = (betta * 180 / Double.pi)
        gamma = (gamma * 180 / Double.pi)
        
        for degree in [alpha, betta, gamma] {
            if degree == .zero {
                return false
            }
        }
        
        return (alpha + betta + gamma).rounded() == 180.0
    }
        
    private func lenghtSquare(_ p1: Point, _ p2: Point) -> Double {
        let xDiff = p1.x - p2.x
        let yDiff = p1.y - p2.y
        
        return pow(xDiff, 2) + pow(yDiff, 2)
    }

    
    // MARK: - Appearance
    
    func navTitle() -> String {
        "Movement"
    }
    
    func infoTitle() -> String {
        "What is Movement?"
    }
    
    func infoDescription() -> String {
        "In Euclidean geometry, an affine transformation, or an affinity (from the Latin, affinis, \"connected with\"), is a geometric transformation that preserves lines and parallelism (but not necessarily distances and angles)."
        + "\n\n"
        + "Affine transformations in two real dimensions include: "
        + "\n\t- Pure translations."
        + "\n\t- Scaling in a given direction, with respect to a line in another direction (not necessarily perpendicular), combined with translation that is not purely in the direction of scaling; taking \"scaling\" in a generalized sense it includes the cases that the scale factor is zero (projection) or negative; the latter includes reflection, and combined with translation it includes glide reflection."
        + "\n\t- Rotation combined with a homothety and a translation."
        + "\n\t- Shear mapping combined with a homothety and a translation."
        + "\n\t- Squeeze mapping combined with a homothety and a translation."
    }
}

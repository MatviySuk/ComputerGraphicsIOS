//
//  Number + Range.swift
//  CGApp
//
//  Created by Matviy Suk on 23.10.2022.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

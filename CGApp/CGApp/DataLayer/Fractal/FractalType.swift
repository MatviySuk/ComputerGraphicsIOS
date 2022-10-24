//
//  FractalType.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import Foundation

enum FractalType: CaseIterable {
    case BrownianMotion
    case Plasma
    
    var title: String {
        switch self {
        case .BrownianMotion:
            return "Brownian Motion"
        case .Plasma:
            return "Plasma"
        }
    }
}

enum PlasmaModifier: CaseIterable {
    case Hue
    case Saturation
    
    var title: String {
        switch self {
        case .Hue:
            return "Hue"
        case .Saturation:
            return "Saturation"
        }
    }
}

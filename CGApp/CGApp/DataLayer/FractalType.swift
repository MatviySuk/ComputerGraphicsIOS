//
//  FractalType.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import Foundation

enum FractalType: CaseIterable {    
    case BrownianMotion
    case Plazma
    
    var title: String {
        switch self {
        case .BrownianMotion:
            return "Brownian Motion"
        case .Plazma:
            return "Plazma"
        }
    }
}

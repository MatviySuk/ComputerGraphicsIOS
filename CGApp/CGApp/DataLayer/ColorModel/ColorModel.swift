//
//  ColorModel.swift
//  CGApp
//
//  Created by Matviy Suk on 02.11.2022.
//

import Foundation

enum ColorModel: CaseIterable {
    case CMYK
    case HSV
    
    var title: String {
        switch self {
        case .CMYK:
            return "CMYK"
        case .HSV:
            return "HSV"
        }
    }
}

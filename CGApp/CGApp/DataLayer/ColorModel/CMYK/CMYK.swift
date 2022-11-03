//
//  CMYK.swift
//  CGApp
//
//  Created by Matviy Suk on 02.11.2022.
//

import Foundation

struct CMYK {
    var cyan: CGFloat
    var magenta: CGFloat
    var yellow: CGFloat
    var black: CGFloat
    
    func toRGBA() -> RGBA32 {
        RGBA32(
            red: UInt8((1 - cyan) * (1 - black) * 255),
            green: UInt8((1 - magenta) * (1 - black) * 255),
            blue: UInt8((1 - yellow) * (1 - black) * 255),
            alpha: 255
        )
    }
}

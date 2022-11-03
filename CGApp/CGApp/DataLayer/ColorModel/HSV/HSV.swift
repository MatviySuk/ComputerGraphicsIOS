//
//  HSV.swift
//  CGApp
//
//  Created by Matviy Suk on 02.11.2022.
//

import Foundation

struct HSV {
    var hue: Int
    var saturation: CGFloat
    var value: CGFloat
    
    func toRGBA() -> RGBA32 {
        if saturation == 0 {
            let v = UInt8(value * 255)
            return RGBA32(red: v, green: v, blue: v, alpha: 255)
        } // Achromatic grey
        
        let angle = Double(hue >= 360 ? 0 : hue)
        let sector = angle / 60 // Sector
        let i = floor(sector)
        let f = sector - i // Factorial part of h
        
        let p = value * (1 - saturation)
        let q = value * (1 - (saturation * f))
        let t = value * (1 - (saturation * (1 - f)))
        
        switch(i) {
        case 0:
            return RGBA32(r: value, g: t, b: p)
        case 1:
            return RGBA32(r: q, g: value, b: p)
        case 2:
            return RGBA32(r: p, g: value, b: t)
        case 3:
            return RGBA32(r: p, g: q, b: value)
        case 4:
            return RGBA32(r: t, g: p, b: value)
        default:
            return RGBA32(r: value, g: p, b: q)
        }
    }
}

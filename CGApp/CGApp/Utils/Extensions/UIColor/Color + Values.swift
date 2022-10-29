//
//  Color + Values.swift
//  CGApp
//
//  Created by Matviy Suk on 04.10.2022.
//

import UIKit

extension UIColor {
    var cmyk: (c: CGFloat, m: CGFloat, y: CGFloat, k: CGFloat) {
        let rgba = self.rgba
        
        let k = 1.0 - max(rgba.r, rgba.g, rgba.b)
        var c = (1.0 - rgba.r - k) / (1.0 - k)
        var m = (1.0 - rgba.g - k) / (1.0 - k)
        var y = (1.0 - rgba.b - k) / (1.0 - k)

        if c.isNaN { c = 0.0 }
        if m.isNaN { m = 0.0 }
        if y.isNaN { y = 0.0 }
    
        return (c, m, y, k)
    }
    
    var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        var r: CGFloat = .zero
        var g: CGFloat = .zero
        var b: CGFloat = .zero
        var alpha: CGFloat = .zero
        
        self.getRed(&r, green: &g, blue: &b, alpha: &alpha)
        
        return (r, g, b, alpha)
    }
    
    var hsb: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = .zero
        var sat: CGFloat = .zero
        var bright: CGFloat = .zero
        var alpha: CGFloat = .zero
        
        self.getHue(&hue, saturation: &sat, brightness: &bright, alpha: &alpha)
        
        return (hue, sat, bright, alpha)
    }
    
    var pixelData: PixelData {
        var r: CGFloat = .zero
        var g: CGFloat = .zero
        var b: CGFloat = .zero
        var a: CGFloat = .zero
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return PixelData(
            a: UInt8(a * 255),
            r: UInt8(r * 255),
            g: UInt8(g * 255),
            b: UInt8(b * 255)
        )
    }
}

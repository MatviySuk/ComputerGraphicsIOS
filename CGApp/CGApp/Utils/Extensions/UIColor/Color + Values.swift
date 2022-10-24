//
//  Color + Values.swift
//  CGApp
//
//  Created by Matviy Suk on 04.10.2022.
//

import UIKit

extension UIColor {
    var hue: CGFloat {
        var hue: CGFloat = .zero
        
        self.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        
        return hue
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

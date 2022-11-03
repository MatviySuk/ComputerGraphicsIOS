//
//  RGBA32.swift
//  CGApp
//
//  Created by Matviy Suk on 29.10.2022.
//

import UIKit

struct RGBA32: Equatable {
    private var color: UInt32

    var red: UInt8 {
        UInt8((color >> 24) & 255)
    }

    var green: UInt8 {
        UInt8((color >> 16) & 255)
    }

    var blue: UInt8 {
        UInt8((color >> 8) & 255)
    }

    var alpha: UInt8 {
        UInt8((color >> 0) & 255)
    }
    
    var uiColor: UIColor {
        UIColor(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }
    
    var isCyanRange: Bool {
        let hue = uiColor.hsb.hue * 360
        return hue >= 150 && hue <= 210
    }

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        let red   = UInt32(red)
        let green = UInt32(green)
        let blue  = UInt32(blue)
        let alpha = UInt32(alpha)
        color = (red << 24) | (green << 16) | (blue << 8) | (alpha << 0)
    }
    
    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(
            red: UInt8(r * 255),
            green: UInt8(g * 255),
            blue: UInt8(b * 255),
            alpha: 255
        )
    }

    static let red     = RGBA32(red: 255, green: 0,   blue: 0,   alpha: 255)
    static let green   = RGBA32(red: 0,   green: 255, blue: 0,   alpha: 255)
    static let blue    = RGBA32(red: 0,   green: 0,   blue: 255, alpha: 255)
    static let white   = RGBA32(red: 255, green: 255, blue: 255, alpha: 255)
    static let black   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 255)
    static let magenta = RGBA32(red: 255, green: 0,   blue: 255, alpha: 255)
    static let yellow  = RGBA32(red: 255, green: 255, blue: 0,   alpha: 255)
    static let cyan    = RGBA32(red: 0,   green: 255, blue: 255, alpha: 255)

    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
    
    func modifyCyanBrightness(_ value: CGFloat) -> RGBA32 {
        isCyanRange
        ? RGBA32(
                red: UInt8(CGFloat(red) * value),
                green: UInt8(CGFloat(green) * value),
                blue: UInt8(CGFloat(blue) * value),
                alpha: alpha
            )
        : self
    }
    
    func normalizedRGB() -> (r: CGFloat, g: CGFloat, b: CGFloat) {
        (
            Double(red) / 255,
            Double(green) / 255,
            Double(blue) / 255
        )
    }
    
    func toCMYK() -> CMYK {
        let rgb = normalizedRGB()
        
        let k = 1.0 - max(rgb.r, rgb.g, rgb.b)
        var c = (1.0 - rgb.r - k) / (1.0 - k)
        var m = (1.0 - rgb.g - k) / (1.0 - k)
        var y = (1.0 - rgb.b - k) / (1.0 - k)

        if c.isNaN { c = 0.0 }
        if m.isNaN { m = 0.0 }
        if y.isNaN { y = 0.0 }
        
        return CMYK(cyan: c, magenta: m, yellow: y, black: k)
    }
    
    func toHSV() -> HSV {
        var hue: Int = .zero
        var sat: CGFloat = .zero
        var value: CGFloat = .zero
        
        let rgb = normalizedRGB()
        let max = max(rgb.r, rgb.g, rgb.b)
        let min = min(rgb.r, rgb.g, rgb.b)
        let range = max - min
        
        if max == min {
            hue = 0
        } else if rgb.b == max {
            hue = Int(60 * ((rgb.r - rgb.g) / range)) + 240
        } else if rgb.g == max {
            hue = Int(60 * ((rgb.b - rgb.r) / range)) + 120
        } else {
            hue = Int(60 * ((rgb.g - rgb.b) / range)) + (rgb.b > rgb.g ? 360 : 0)
        }
                        
        sat = max == .zero ? 0 : (1 - min / max)
        value = max
        
        if sat.isNaN { sat = 0.0 }
        if value.isNaN { value = 0.0 }
        
        return HSV(
            hue: hue,
            saturation: sat,
            value: value
        )
    }

    static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool {
        return lhs.color == rhs.color
    }
}

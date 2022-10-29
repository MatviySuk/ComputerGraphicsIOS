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

    static let red     = RGBA32(red: 255, green: 0,   blue: 0,   alpha: 255)
    static let green   = RGBA32(red: 0,   green: 255, blue: 0,   alpha: 255)
    static let blue    = RGBA32(red: 0,   green: 0,   blue: 255, alpha: 255)
    static let white   = RGBA32(red: 255, green: 255, blue: 255, alpha: 255)
    static let black   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 255)
    static let magenta = RGBA32(red: 255, green: 0,   blue: 255, alpha: 255)
    static let yellow  = RGBA32(red: 255, green: 255, blue: 0,   alpha: 255)
    static let cyan    = RGBA32(red: 0,   green: 255, blue: 255, alpha: 255)

    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
    
//    mutating func modifyBrightness(_ value: CGFloat) {
//        color = RGBA32(
//            red: UInt8(CGFloat(red) * value),
//            green: UInt8(CGFloat(green) * value),
//            blue: UInt8(CGFloat(blue) * value),
//            alpha: alpha
//        ).color
//    }
    
    func modifyBrightness(_ value: CGFloat) -> RGBA32 {
        RGBA32(
            red: UInt8(CGFloat(red) * value),
            green: UInt8(CGFloat(green) * value),
            blue: UInt8(CGFloat(blue) * value),
            alpha: alpha
        )
    }

    static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool {
        return lhs.color == rhs.color
    }
}

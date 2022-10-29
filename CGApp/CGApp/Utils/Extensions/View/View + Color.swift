//
//  View + Color.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import SwiftUI

extension UIView {
    func getColorByPoint(_ point: CGPoint) -> UIColor {
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        var pixelData:[UInt8] = [0, 0, 0, 0]
        
        let context = CGContext(
            data: &pixelData,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )
        
        context?.translateBy(x: -point.x, y: -point.y)
        
        if let _context = context {
            layer.render(in: _context)
        }
        
        let red:CGFloat = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green:CGFloat = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue:CGFloat = CGFloat(pixelData[2]) / CGFloat(255.0)
        let alpha:CGFloat = CGFloat(pixelData[3]) / CGFloat(255.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

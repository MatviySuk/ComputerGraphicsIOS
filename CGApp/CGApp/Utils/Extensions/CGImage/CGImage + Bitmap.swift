//
//  CGImage + Bitmap.swift
//  CGApp
//
//  Created by Matviy Suk on 23.10.2022.
//

import UIKit

extension CGImage {
    static func generateFromBitmap(_ bitmap: [PixelData], width: Int, height: Int) -> CGImage? {
        guard width > 0 && height > 0,
              bitmap.count == width * height else {
            return nil
        }
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = bitmap // Copy to mutable []
        guard let providerRef = CGDataProvider(
            data: NSData(
                bytes: &data,
                length: data.count * MemoryLayout<PixelData>.size
            )) else {
            return nil
        }
        
        return CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<PixelData>.size,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
    }
}

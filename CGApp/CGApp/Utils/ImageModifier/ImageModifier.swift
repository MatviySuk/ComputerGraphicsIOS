//
//  ImageModifier.swift
//  CGApp
//
//  Created by Matviy Suk on 29.10.2022.
//

import Foundation
import UIKit

struct ImageModifier {
    static func modifyUIImageByCyan(
        _ image: UIImage,
        colorModel: ColorModel,
        brightness: CGFloat
    ) -> UIImage? {
        guard let inputCGImage = image.cgImage else {
            print("unable to get cgImage")
            return nil
        }
        
        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let width            = inputCGImage.width
        let height           = inputCGImage.height
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = RGBA32.bitmapInfo

        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
            print("unable to create context")
            return nil
        }
        
        context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let buffer = context.data else {
            print("unable to get context data")
            return nil
        }
        
        let pixelBuffer = buffer.bindMemory(to: RGBA32.self, capacity: width * height)
        
        for row in 0 ..< Int(height) {
            for column in 0 ..< Int(width) {
                let offset = row * width + column
                pixelBuffer[offset] = colorModel == .CMYK
                ? pixelBuffer[offset].toCMYK().toRGBA()
                : pixelBuffer[offset].toHSV().toRGBA().modifyCyanBrightness(brightness)
            }
        }

        return UIImage(
            cgImage: context.makeImage()!,
            scale: image.scale,
            orientation: image.imageOrientation
        )
    }
}

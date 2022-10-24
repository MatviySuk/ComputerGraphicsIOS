//
//  View + Image.swift
//  CGApp
//
//  Created by Matviy Suk on 02.10.2022.
//

import SwiftUI

extension View {
    func screenshotView(_ closure: @escaping ScreenshotMakerClosure) -> some View {
        let screenshotView = ScreenshotMakerView(closure)
        return overlay(screenshotView.allowsHitTesting(false))
    }
}

//
//  ColourImageViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import SwiftUI

final class ColourImageViewModel: ObservableObject {
    var screenshotMaker: ScreenshotMaker?
    
    @Published var uiImage: UIImage
    
    var point: CGPoint? = nil {
        didSet {
            if point != nil {
                objectWillChange.send()
            }
        }
    }
    
    var color = UIColor.clear {
        didSet {
            point = nil
        }
    }
    
    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    // MARK: - Actions
    
    func updateImage(_ uiImage: UIImage) {
        self.uiImage = uiImage
    }
}

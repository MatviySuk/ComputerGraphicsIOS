//
//  ColourImageViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import SwiftUI

final class ColourImageViewModel: ObservableObject {    
    @Published var uiImage: UIImage
    @Published var colorModel: ColorModel
    
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
    
    init(uiImage: UIImage, colorModel: ColorModel) {
        self.uiImage = uiImage
        self.colorModel = colorModel
    }
    
    // MARK: - Actions
    
    func updateImage(_ uiImage: UIImage, brightness: CGFloat) {
        if let updatedImage = ImageModifier.modifyUIImageByCyan(
            uiImage,
            colorModel: colorModel,
            brightness: brightness
        ) {
            self.uiImage = updatedImage
        }
    }
    
    func updateColorModel(_ model: ColorModel) {
        self.colorModel = model
    }
}

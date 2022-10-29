//
//  ImagePresenterView.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import SwiftUI

struct ImagePresenterView: UIViewRepresentable {
    typealias UIViewType = ImagePresenter
    
    @EnvironmentObject var viewModel: ColourImageViewModel
        
    
    func makeUIView(context: Context) -> UIViewType {        
        ImagePresenter(uiImage: viewModel.uiImage)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Type casting is not working without conditional downcasting.
        // ONLY Forced downcasting!
        
        if (uiView.layer.contents as! CGImage) != viewModel.uiImage.cgImage {
            uiView.layer.contents = viewModel.uiImage.cgImage
        }
        
        if let point = viewModel.point {
            viewModel.color = uiView.getColorByPoint(point)
        }
    }
}

//
//  ColourImageView.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import SwiftUI

struct ColourImageView: View {
    @StateObject var viewModel: ColourImageViewModel
    
    var body: some View {
        VStack {
            CMYKDescription
            Divider()
            HSVDescription
            
//            Divider()
//            RGBDescription
            
            imageView
        }
    }
    
    var imageView: some View {
        ImagePresenterView()
            .environmentObject(viewModel)
            .gesture(DragGesture(
                minimumDistance: .zero,
                coordinateSpace: .local
            ).onChanged { value in
                viewModel.point = value.location
            })
    }
    
    var HSVDescription: some View {
        HStack(spacing: 20) {
            Text("H: \(Int(viewModel.color.hsb.hue * 360))")
            Text(String(format: "S: %.3lf", viewModel.color.hsb.saturation))
            Text(String(format: "V: %.3lf", viewModel.color.hsb.brightness))
        }
    }
    
    var CMYKDescription: some View {
        HStack(spacing: 20) {
            Text(String(format: "C: %.3lf", viewModel.color.cmyk.c))
            Text(String(format: "M: %.3lf", viewModel.color.cmyk.m))
            Text(String(format: "Y: %.3lf", viewModel.color.cmyk.y))
            Text(String(format: "K: %.3lf", viewModel.color.cmyk.k))
        }
    }
    
//    var RGBDescription: some View {
//        HStack(spacing: 20) {
//            Text("R: \(Int(viewModel.color.rgba.r * 255))")
//            Text("G: \(Int(viewModel.color.rgba.g * 255))")
//            Text("B: \(Int(viewModel.color.rgba.b * 255))")
//        }
//    }
}

struct ColourImageView_Previews: PreviewProvider {
    static var previews: some View {
        ColourImageView(viewModel: .init(uiImage: UIImage(named: "Gradient")!))
    }
}

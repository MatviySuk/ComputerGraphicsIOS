//
//  FractalView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI
import UIKit
import Metal

struct FractalGenerationView: UIViewRepresentable {
    // MARK: - Types
    typealias UIViewType = FractalView
    
    // MARK: - Properties
    @EnvironmentObject var viewModel: FractalsViewModel
    @Binding var showFractal: Bool
    
    // MARK: - Actions
    func makeUIView(context: Context) -> UIViewType {
        var uiView: UIViewType
        
        if viewModel.fractalType == .BrownianMotion {
            uiView = BrownianMotionView(
                color: viewModel.fractalColorValue
            )
        } else {
            uiView = PlasmaView(
                color: viewModel.fractalColorValue,
                plasmaModifier: viewModel.plasmaModifier
            )

        }
                
        return uiView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if uiView.showFractal != showFractal {
            viewModel.generateFractal(rect: uiView.bounds)
            if let plasmaView = uiView as? PlasmaView {
                plasmaView.updatePoints(viewModel.plasmaPoints)
            }

            if let brownianMotionView = uiView as? BrownianMotionView {
                brownianMotionView.updatePoints(viewModel.brownianMotionPoint)
            }
            
            uiView.showFractal = showFractal
            uiView.setNeedsDisplay()
        }
    }
}

struct FractalView_Previews: PreviewProvider {
    static var previews: some View {
        FractalGenerationView(showFractal: .constant(false))
    }
}

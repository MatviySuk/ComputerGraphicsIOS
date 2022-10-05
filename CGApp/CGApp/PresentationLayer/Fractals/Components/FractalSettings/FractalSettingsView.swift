//
//  FractalSettingsView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct FractalSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: FractalsViewModel
    
    private let iterationsRange = 20...200
    
    var body: some View {
        NavigationStack {
            Form {
                fractalType
                                
                fractalDetailSettings
            }
            .background(Color.red)
            .navigationTitle("Fractal Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("Close")
                    })
                }
            }
        }
    }
    
    var fractalType: some View {
        return Section("Fractal type") {
            Picker("", selection: $viewModel.fractalType) {
                ForEach(FractalType.allCases, id: \.self) { type in
                    Text(type.title).tag(type)
                }
            }.pickerStyle(.segmented)
        }
    }
    
    var fractalDetailSettings: some View {
        Section("\(viewModel.fractalType.title) Settings") {
            if viewModel.fractalType == .BrownianMotion {
                Stepper("Number of iterations: \(viewModel.iterations)",
                        value: $viewModel.iterations,
                        in: iterationsRange,
                        step: 10
                )
            } else {
                Picker("Modify color by", selection: $viewModel.plasmaModifier) {
                    ForEach(PlasmaModifier.allCases, id: \.self) { type in
                        Text(type.title).tag(type)
                    }
                }.pickerStyle(.menu)
            }
            
            if viewModel.plasmaModifier == .Saturation
                || viewModel.fractalType == .BrownianMotion {
                ColorPicker("Pick Base Color", selection: $viewModel.fractalColorValue)
            }
        }
    }
}

struct FractalSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FractalSettingsView()
            .environmentObject(FractalsViewModel())
    }
}

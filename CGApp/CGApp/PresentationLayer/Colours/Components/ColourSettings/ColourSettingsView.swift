//
//  ColourSettingsView.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import SwiftUI

struct ColourSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ColoursViewModel
    
    private let brightnessRange: ClosedRange<CGFloat> = 0.01...1.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Cyan Brightness") {
                    Slider(
                        value: $viewModel.cyanBrightness,
                        in: brightnessRange,
                        label: {},
                        minimumValueLabel: {
                            Image(systemName: "sun.min.fill")
                                .foregroundColor(.cyan30)
                        },
                        maximumValueLabel: {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.cyan70)
                        }
                    )
                    .tint(.cyan)
                }
            }
            .navigationTitle("Color Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("Close")
                    }).buttonStyle(ProgressButtonStyle())
                }
            }
        }
    }
}

struct ColorSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ColourSettingsView()
            .environmentObject(ColoursViewModel())
    }
}

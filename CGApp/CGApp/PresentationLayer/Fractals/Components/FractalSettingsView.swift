//
//  FractalSettingsView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct FractalSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var fractalType: FractalType
    @Binding var iterations: Int
    
    private let iterationsRange = 1...10
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Fractal type") {
                    Picker("", selection: $fractalType) {
                        ForEach(FractalType.allCases, id: \.self) { type in
                            Text(type.title).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Stepper("Number of iterations: \(iterations)",
                        value: $iterations,
                        in: iterationsRange
                )
            }
            .background(Color.red)
            .navigationTitle("Fractal settings")
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
}

struct FractalSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FractalSettingsView(fractalType: .constant(.Plazma), iterations: .constant(1))
    }
}

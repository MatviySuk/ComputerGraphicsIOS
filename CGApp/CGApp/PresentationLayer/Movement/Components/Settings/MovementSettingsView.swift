//
//  MovementSettingsView.swift
//  CGApp
//
//  Created by Matviy Suk on 12.11.2022.
//

import SwiftUI

struct MovementSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MovementViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Step for Y=X") {
                    Stepper("X = \(String(format: "%.1lf", viewModel.stepByXY))",
                            value: $viewModel.stepByXY,
                            in: 0.0...10.0,
                            step: 0.5
                    )
                }
                
                Section("Rotation angle") {
                    Stepper("Angle = \(String(format: "%.1lf", viewModel.rotationAngle))",
                            value: $viewModel.rotationAngle,
                            in: 0.0...180,
                            step: 10
                    )
                }
                
                ForEach($viewModel.startPoints) { $point in
                    Section("Enter \(point.name)") {
                        Stepper("\(point.name)x = \(String(format: "%.1lf", point.x))") {
                            if viewModel.pointRange.upperBound > point.x {
                                repeat {
                                    point.x += viewModel.pointStep
                                } while(!viewModel.isPointsTriangle())
                            }
                        } onDecrement: {
                            if viewModel.pointRange.lowerBound < point.x {
                                repeat {
                                    point.x -= viewModel.pointStep
                                } while(!viewModel.isPointsTriangle())
                            }
                        }
                        
                        Stepper("\(point.name)y = \(String(format: "%.1lf", point.y))") {
                            if viewModel.pointRange.upperBound > point.y {
                                repeat {
                                    point.y += viewModel.pointStep
                                } while(!viewModel.isPointsTriangle())
                            }
                        } onDecrement: {
                            if viewModel.pointRange.lowerBound < point.y {
                                repeat {
                                    point.y -= viewModel.pointStep
                                } while(!viewModel.isPointsTriangle())
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movement Settings")
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

struct MovementSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MovementSettingsView()
    }
}

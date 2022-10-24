//
//  FractalsView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct FractalsMainView: View {
    // MARK: - Properties
    @StateObject var viewModel = FractalsViewModel()
    @State private var screenshotMaker: ScreenshotMaker?
    
    @State private var showSheet = false
    @State private var showSettings = false
    
    @State private var showFractal = false
    
    // MARK: - Views
    
    var body: some View {
        NavigationStack {
            ZStack {
                    backView
                        .opacity(!showFractal ? 1.0 : 0.0)
                if !showSheet {
                    fractalView
                        .opacity(showFractal ? 1.0 : 0.0)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.fractalType.title)
            .sheet(isPresented: $showSheet) { sheetView }
            .alert(
                "Save Image",
                isPresented: $viewModel.presentAlert,
                actions: { },
                message: { 
                    Text(
                        viewModel.saveImageResult.message
                        + (viewModel.saveImageResult.error?.localizedDescription ?? "")
                    )
                }
            )
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    infoButton
                    shareButton
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    playButton
                    settingsButton
                }
            }
        }
    }
    
    var fractalView: some View {
        FractalGenerationView(showFractal: $showFractal)
            .environmentObject(viewModel)
            .screenshotView { screenshotMaker in
                self.screenshotMaker = screenshotMaker
            }
            .onDisappear {
                self.screenshotMaker = nil
            }
    }
    
    var backView: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Group {
                Text("To generate a fractal press ")
                + Text(Image(systemName: "play.fill"))
                    .foregroundColor(.accentColor)
                + Text(" button in upper-right corner")
            }
            .font(.system(size: 34, weight: .semibold))
            .multilineTextAlignment(.center)
            .padding([.horizontal, .bottom])
            
            Spacer()
        }
    }
    
    var sheetView: some View {
        Group {
            if showSettings {
                FractalSettingsView()
                    .environmentObject(viewModel)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
            } else {
                ShortInfoView(
                    title: viewModel.infoTitle(),
                    description: viewModel.infoDescription())
            }
        }
    }
    
    
    // MARK: - Toolbar Items
    var infoButton: some View {
        Button(action: {
            withAnimation {
                showSettings = false
                actionButtonPressed()
            }
        }, label: {
            Image(systemName: "book.fill")
                .tint(.orange)
        })
    }
    
    var shareButton: some View {
        Button(action: {
            if let image = screenshotMaker?.screenshot() {
                viewModel.saveImage(image)
            }
        }, label: {
            Image(systemName: "square.and.arrow.down")
                .opacity(showFractal ? 1.0 : 0.0)
        }).buttonStyle(ProgressButtonStyle())
    }
    
    var playButton: some View {
        Button(action: {
            withAnimation {
                showFractal.toggle()
            }
        }, label: {
                Image(systemName: showFractal ? "pause.fill" : "play.fill")
        }).buttonStyle(ProgressButtonStyle())
    }
    
    var settingsButton: some View {
        Button(action: {
            withAnimation {
                showSettings = true
                actionButtonPressed()
            }
        }, label: {
            Image(systemName: "gearshape")
        })
    }
    
    // MARK: - Actions
    
    private func actionButtonPressed() {
        showFractal = false
        showSheet.toggle()
    }
}

struct FractalsView_Previews: PreviewProvider {
    static var previews: some View {
        FractalsMainView()
    }
}

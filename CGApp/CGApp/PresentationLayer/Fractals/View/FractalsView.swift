//
//  FractalsView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct FractalsView: View {
    @StateObject var viewModel = FractalsViewModel()
    @State private var showSheet = false
    @State private var showSettings = false
    @State private var playPressed = false
        
    var body: some View {
        NavigationStack {
            ZStack {
                if playPressed {
                    FractalGenerationView(playPressed: $playPressed)
                } else {
                    backView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.fractalType.title)
            .sheet(isPresented: $showSheet) { sheetView }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    infoButton
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    playButton
                    settingsButton
                }
            }
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
                FractalSettingsView(
                    fractalType: $viewModel.fractalType,
                    iterations: $viewModel.iterations)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
            } else {
                ShortInfoView(
                    title: viewModel.infoTitle(),
                    description: viewModel.infoDescription())
            }
        }
    }
    
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
    
    var playButton: some View {
        Button(action: {
            withAnimation {
                playPressed.toggle()
            }
        }, label: {
            Image(systemName: playPressed ? "pause.fill" : "play.fill")
        })
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
    
    func actionButtonPressed() {
        playPressed = false
        showSheet.toggle()
    }
}

struct FractalsView_Previews: PreviewProvider {
    static var previews: some View {
        FractalsView()
    }
}

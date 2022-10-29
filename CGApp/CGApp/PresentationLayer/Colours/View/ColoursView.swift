//
//  ColoursView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI
import PhotosUI

struct ColoursView: View {
    // MARK: - Properties
    @StateObject var viewModel = ColoursViewModel()
    
    @State private var showSheet = false
    @State private var showSettings = true
        
    // MARK: - Views
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                colourImageView
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.navTitle())
            .sheet(isPresented: $showSheet) { sheetView }
            .toolbar { toolbarItems }
            .alert(viewModel.alertTitle(),
                   isPresented: $viewModel.presentAlert,
                   actions: { },
                   message: { alertMessage }
            )
            
        }
    }
    
    var colourImageView: some View {
        ColourImageView(viewModel: viewModel.imageViewModel)
    }
    
    var alertMessage: some View {
        Text(
            viewModel.saveImageResult.message
            + (viewModel.saveImageResult.error?.localizedDescription ?? "")
        )
    }
        
    var sheetView: some View {
        Group {
            if showSettings {
                ColourSettingsView()
                    .environmentObject(viewModel)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(200)])
            } else {
                ShortInfoView(
                    title: viewModel.infoTitle(),
                    description: viewModel.infoDescription())
            }
        }
    }
    
    
    // MARK: - Toolbar Items
    
    var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                infoButton
                shareButton
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                chooseImage
                settingsButton
            }
        }
    }
    
    var infoButton: some View {
        Button(action: {
            withAnimation {
                showSheet(with: false)
            }
        }, label: {
            Image(systemName: "book.fill")
                .tint(.orange)
        })
    }
    
    var shareButton: some View {
        Button(action: {
            viewModel.saveImage()
        }, label: {
            Image(systemName: "square.and.arrow.down")
        }).buttonStyle(ProgressButtonStyle())
    }
    
    var chooseImage: some View {
        PhotosPicker(
            selection: $viewModel.selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Image(systemName: "photo.on.rectangle")
        }
    }
    
    var settingsButton: some View {
        Button(action: {
            withAnimation {
                showSheet(with: true)
            }
        }, label: {
            Image(systemName: "gearshape")
        })
    }
    
    // MARK: - Actions
    
    private func showSheet(with settings: Bool) {
        showSettings = settings
        showSheet.toggle()
    }
}

struct ColoursView_Previews: PreviewProvider {
    static var previews: some View {
        ColoursView()
    }
}

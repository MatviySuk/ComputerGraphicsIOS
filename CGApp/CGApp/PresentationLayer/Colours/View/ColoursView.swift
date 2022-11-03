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
    
    @State private var showInfo = false
    @State private var showSettings = false
        
    // MARK: - Views
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                colourImageView
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.navTitle())
            .toolbar { toolbarItems }
            .sheet(isPresented: $showInfo) { infoView }
            .sheet(isPresented: $showSettings, onDismiss: {
                viewModel.updateImage()
            }) { settingsView }
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
    
    var settingsView: some View {
        ColourSettingsView()
            .environmentObject(viewModel)
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(300)])
    }
    
    var infoView: some View {
        ShortInfoView(
            title: viewModel.infoTitle(),
            description: viewModel.infoDescription())
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
                showInfo.toggle()
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
                showSettings.toggle()
            }
        }, label: {
            Image(systemName: "gearshape")
        })
    }
    
    // MARK: - Actions

    
}

struct ColoursView_Previews: PreviewProvider {
    static var previews: some View {
        ColoursView()
    }
}

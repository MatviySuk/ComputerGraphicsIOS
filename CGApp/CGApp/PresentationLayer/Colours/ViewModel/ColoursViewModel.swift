//
//  ColoursViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 27.10.2022.
//

import SwiftUI
import PhotosUI

final class ColoursViewModel: ObservableObject {
    // MARK: - Properties
    @Published var presentAlert = false
    @Published var cyanBrightness: CGFloat = 0.5
    
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet {
            retriveImages()
        }
    }
        
    private(set) var imageViewModel: ColourImageViewModel
    private var originalImage: UIImage = UIImage(named: "Gradient")!
    
    private let imageSaver = ImageSaver()
    private(set) var saveImageResult: (message: String, error: Error?) = ("", nil) {
        didSet {
            self.presentAlert = true
        }
    }
    
    // MARK: - Init
    
    init() {
        self.imageViewModel = ColourImageViewModel(uiImage: originalImage)
    }
    
    
    // MARK: - Actions
    
    func updateImageBrightness() {
        Task {
            await MainActor.run {
                if let updatedImage = ImageModifier.modifyUIImageByCyan(
                    originalImage,
                    brightness: cyanBrightness
                ) {
                    imageViewModel.updateImage(updatedImage)
                }
            }
        }
    }
    
    func retriveImages() {
        Task {
            await MainActor.run {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        originalImage = image
                        imageViewModel.updateImage(image)
                    }
                }
            }
        }
    }
        
    func saveImage() {
        if let uiImage = imageViewModel.screenshotMaker?.screenshot() {
            imageSaver.successHandler = { [weak self] in
                self?.saveImageResult = ("The image is successfully saved!", nil)
            }
            
            imageSaver.errorHandler = { [weak self] error in
                self?.saveImageResult = ("The image is not saved!", error)
            }
            
            imageSaver.writeToPhotoAlbum(image: uiImage)
        }
    }
    
    // MARK: - Appearance
    
    func navTitle() -> String {
        "Color"
    }
    
    func alertTitle() -> String {
        "Save Image"
    }
    
    func infoTitle() -> String {
        "What is Color?"
    }
    
    func infoDescription() -> String {
        "Color is defined as the aspect of things that is caused by differing qualities of light being reflected or emitted by them. To see color, you have to have light. When light shines on an object some colors bounce off the object and others are absorbed by it. Our eyes only see the colors that are bounced off or reflected."
        + "\n\n"
        + "When working with color, particularly in design and print, we distinguish two methods: additive and subtractive. On a monitor, display or television screen, colors consist of red, green and blue (RGB). But when it comes to printed media, prints or paint for objects or dyes, cyan, magenta and yellow (CMY) form the basis to compose colors. We call working with RGB the additive use and working with CMY the subtractive use of color."
    }
}

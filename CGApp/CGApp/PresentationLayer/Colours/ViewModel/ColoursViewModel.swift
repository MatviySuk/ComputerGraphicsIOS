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
        "Colour"
    }
    
    func alertTitle() -> String {
        "Save Image"
    }
    
    func infoTitle() -> String {
        "What is Color?"
    }
    
    func infoDescription() -> String {
        "A fractal is a non-regular geometric shape that has the same degree of non-regularity on all scales. Fractals can be thought of as never-ending patterns."
        + "\n\n"
        + "Plasma fractal also known, as the diamond-square algorithm, can be used to generate realistic-looking landscapes, and different implementations are used in computer graphics software such as Terragen. It is also applicable as a common component in procedural textures."
        + "\n\n"
        + "Brownian motion is the random motion of particles suspended in a medium (a liquid or a gas). This pattern of motion typically consists of random fluctuations in a particle's position inside a fluid sub-domain, followed by a relocation to another sub-domain. Each relocation is followed by more fluctuations within the new closed volume. This pattern describes a fluid at thermal equilibrium, defined by a given temperature"
    }
}

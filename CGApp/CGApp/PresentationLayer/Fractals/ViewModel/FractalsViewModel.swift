//
//  FractalsViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

final class FractalsViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    @Published var fractalType: FractalType = .Plasma
    @Published var plasmaModifier: PlasmaModifier = .Saturation
    @Published var fractalColorValue: CGColor = UIColor.systemPurple.cgColor
    @Published var roughness: Double = 1.0
    @Published var iterations: Int = 50
    @Published var presentAlert = false
    
    private let imageSaver = ImageSaver()
    private(set) var saveImageResult: (message: String, error: Error?) = ("", nil) {
        didSet {
            self.presentAlert = true
        }
    }
    
    var plasmaPoints = [[CGFloat]]()
    var brownianMotionPoint = [CGPoint]()
    
    // MARK: - Actions
    
    func generateFractal(rect: CGRect) {
        switch fractalType {
        case .BrownianMotion:
            self.plasmaPoints.removeAll()
            self.brownianMotionPoint = BrownianMotionGenerator(
                rect: rect
            ).fractalPoints(iterations: iterations)
        case .Plasma:
            self.brownianMotionPoint.removeAll()
            self.plasmaPoints = PlasmaGenerator(rect: rect).plasmaFractal(roughness: roughness)
        }
    }
    
    func saveImage(_ uiImage: UIImage) {
        imageSaver.successHandler = { [weak self] in
            self?.saveImageResult = ("The image is successfully saved!", nil)
        }

        imageSaver.errorHandler = { [weak self] error in
            self?.saveImageResult = ("The image is not saved!", error)
        }
        
        imageSaver.writeToPhotoAlbum(image: uiImage)
    }
    
    // MARK: - Appearance
    
    func infoTitle() -> String {
        "What is fractal?"
    }
    
    func infoDescription() -> String {
        "A fractal is a non-regular geometric shape that has the same degree of non-regularity on all scales. Fractals can be thought of as never-ending patterns."
        + "\n\n"
        + "Plasma fractal also known, as the diamond-square algorithm, can be used to generate realistic-looking landscapes, and different implementations are used in computer graphics software such as Terragen. It is also applicable as a common component in procedural textures."
        + "\n\n"
        + "Brownian motion is the random motion of particles suspended in a medium (a liquid or a gas). This pattern of motion typically consists of random fluctuations in a particle's position inside a fluid sub-domain, followed by a relocation to another sub-domain. Each relocation is followed by more fluctuations within the new closed volume. This pattern describes a fluid at thermal equilibrium, defined by a given temperature"
    }
}

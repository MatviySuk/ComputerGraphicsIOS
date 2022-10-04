//
//  FractalsViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

final class FractalsViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    @Published var fractalType: FractalType = .BrownianMotion
    @Published var plasmaModifier: PlasmaModifier = .Saturation
    @Published var fractalColorValue: CGColor = UIColor.systemPurple.cgColor
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
            self.plasmaPoints = PlasmaGenerator(rect: rect).plasmaFractal(roughness: 1.0)
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
        "Lorem Ipsum"
    }
    
    func infoDescription() -> String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consequat felis ut ornare elementum. Cras in nibh vehicula mauris semper suscipit sed quis risus. Ut porta ullamcorper odio, pellentesque ultrices ligula mattis sed. Sed consequat finibus fermentum. Praesent ac diam quis lectus egestas dignissim. Proin vel quam vitae mi semper euismod id facilisis ligula. Nunc et tempus massa, sed vestibulum sem. Quisque laoreet in magna eu vulputate. Aliquam id est lacus. In tempus dignissim tortor. Integer sit amet ultricies tellus. Morbi vehicula quam sit amet augue gravida dignissim. Curabitur a eros risus."
    }
}

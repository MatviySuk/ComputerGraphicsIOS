//
//  FractalsViewModel.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import Foundation

final class FractalsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var fractalType: FractalType = .BrownianMotion
    @Published var iterations: Int = 1
    
    
    // MARK: - Appearance
    
    func infoTitle() -> String {
        "Lorem Ipsum"
    }
    
    func infoDescription() -> String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consequat felis ut ornare elementum. Cras in nibh vehicula mauris semper suscipit sed quis risus. Ut porta ullamcorper odio, pellentesque ultrices ligula mattis sed. Sed consequat finibus fermentum. Praesent ac diam quis lectus egestas dignissim. Proin vel quam vitae mi semper euismod id facilisis ligula. Nunc et tempus massa, sed vestibulum sem. Quisque laoreet in magna eu vulputate. Aliquam id est lacus. In tempus dignissim tortor. Integer sit amet ultricies tellus. Morbi vehicula quam sit amet augue gravida dignissim. Curabitur a eros risus."
    }
}

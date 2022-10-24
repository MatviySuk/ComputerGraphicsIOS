//
//  ProgressButtonStyle.swift
//  CGApp
//
//  Created by Matviy Suk on 04.10.2022.
//

import SwiftUI

struct ProgressButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            configuration.label
                .opacity(configuration.isPressed ? 0.0 : 1.0)
            
            ProgressView()
                .tint(.accentColor)
                .progressViewStyle(.circular)
                .opacity(configuration.isPressed ? 1.0 : 0.0)
        }
        .foregroundColor(.accentColor)
    }
}

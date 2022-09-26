//
//  IntroView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct IntroView: View {
    @Binding var showIntro: Bool
    @Environment(\.dismiss) var dismiss
    private let title = "Welcome to Computer Graphics"
    
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
                Text(title)
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
            Spacer()
            
            VStack(alignment: .leading, spacing: 30) {
                fractalsItem
                coloursItem
                movementItem
            }
            .layoutPriority(5)
            
            Spacer()
                        
            Button(action: {
                withAnimation {
                    showIntro.toggle()
                }
            }, label: {
                HStack {
                    Spacer()
                    Text("Lets Start!")
                    Spacer()
                }
                .frame(height: 38)
            })
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
            
        }
        .padding()
        .background(Color.white)
    }
    
    var fractalsItem: some View {
        IntroItemView(
            icon: Image(systemName: "scribble.variable"),
            title: "Fractals",
            description: "Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals Fractals  "
        )
    }
    
    var coloursItem: some View {
        IntroItemView(
            icon: Image(systemName: "paintpalette.fill"),
            title: "Colours",
            description: "Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours Colours  "
        )
    }
    
    var movementItem: some View {
        IntroItemView(
            icon: Image(systemName: "move.3d"),
            title: "Movement",
            description: "Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement Movement  "
        )
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(showIntro: .constant(true))
    }
}

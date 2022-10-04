//
//  ContentView.swift
//  CGApp
//
//  Created by Matviy Suk on 22.09.2022.
//

import SwiftUI

struct MainView: View {
    @State private var showIntro = false
    
    var body: some View {
            if showIntro {
                IntroView(showIntro: $showIntro)
            } else {
                tabbar
                    .toolbar(.visible, for: .navigationBar)
            }
            
    }
    
    var tabbar: some View {
        TabView {
            FractalsMainView()
                .tabItem {
                    Label("Fractals", systemImage: "scribble.variable")
                }
            ColoursView()
                .tabItem {
                    Label("Colours", systemImage: "paintpalette.fill")
                }
            MovementView()
                .tabItem {
                    Label("Movement", systemImage: "move.3d")
                }
        }
        .accentColor(.accentColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

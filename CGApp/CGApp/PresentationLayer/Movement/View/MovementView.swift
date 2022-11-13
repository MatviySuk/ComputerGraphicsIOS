//
//  MovementView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI
import Charts

struct MovementView: View {
    @StateObject var viewModel = MovementViewModel()
    
    @State private var startPlay = false
    @State private var showInfo = false
    @State private var showSettings = false
        
    // MARK: - Views
    
    var body: some View {
        NavigationStack {
            VStack {
                chartView
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.navTitle())
            .toolbar { toolbarItems }
            .sheet(isPresented: $showInfo) { infoView }
            .sheet(isPresented: $showSettings, onDismiss: {
                viewModel.resetPoints()
            }) { settingsView }
        }
    }
    
    var chartView: some View {
        GeometryReader { geo in
            Chart {
                ForEach(viewModel.limitPoints) {
                    PointMark(
                        x: .value("", $0.x),
                        y: .value("", $0.y * (geo.size.height / geo.size.width))
                    )
                    .foregroundStyle(.clear)
                }
                
                PointMark(
                    x: .value("", 0.0),
                    y: .value("", 0.0)
                ).foregroundStyle(.red)
                
                ForEach(viewModel.points) { point in
                    LineMark(
                        x: .value(point.name, point.x),
                        y: .value(point.name, point.y)
                    )
                    .symbol {
                        Text(point.name)
                        .bold()
                        .offset(viewModel.getOffsetFor(point))
                    }
                }
            }
        }
    }
        
    var settingsView: some View {
        MovementSettingsView()
            .environmentObject(viewModel)
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(UIScreen.main.bounds.height / 3), .large])
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
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                playButton
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
    
    var playButton: some View {
        Button(action: {
            withAnimation {
                viewModel.applyMovement()
            }
        }, label: {
                Image(systemName: startPlay ? "pause.fill" : "play.fill")
        }).buttonStyle(ProgressButtonStyle())
    }

    
    var settingsButton: some View {
        Button(action: {
            withAnimation {
                viewModel.resetPoints()
                showSettings.toggle()
            }
        }, label: {
            Image(systemName: "gearshape")
        })
    }
    
    // MARK: - Actions

}

struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView()
    }
}

//
//  FractalView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI
import UIKit
import Metal

struct FractalGenerationView: UIViewRepresentable {
    @Binding var playPressed: Bool
    
    func makeUIView(context: Context) -> DisplayFractalView {
        DisplayFractalView()
    }
    
    func updateUIView(_ uiView: DisplayFractalView, context: Context) {
        uiView.playPressed = playPressed
        uiView.setNeedsDisplay()
    }
}

final class PlasmaFractalViewController: UIViewController {
    var device: MTLDevice!
    var metalLayer: CAMetalLayer!
    var vertexBuffer: MTLBuffer!
    var pipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    var timer: CADisplayLink!

    let vertexData: [Float] = [
       0.0,  1.0, 0.0,
      -1.0, -1.0, 0.0,
       1.0, -1.0, 0.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        device = MTLCreateSystemDefaultDevice()
//
//        metalLayer = CAMetalLayer()
//        metalLayer.device = device
//        metalLayer.pixelFormat = .bgra8Unorm
//        metalLayer.framebufferOnly = true
//        metalLayer.frame = view.layer.frame
//        view.layer.addSublayer(metalLayer)
//
//        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0]) // 1
//        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: []) // 2
//
//        let defaultLibrary = device.makeDefaultLibrary()!
//        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
//        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
//
//        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
//        pipelineStateDescriptor.vertexFunction = vertexProgram
//        pipelineStateDescriptor.fragmentFunction = fragmentProgram
//        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
//
//        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
//
//        commandQueue = device.makeCommandQueue()
//
//        timer = CADisplayLink(target: self, selector: #selector(gameloop))
//        timer.add(to: RunLoop.main, forMode: .default)
    }
    
    func render() {
        guard let drawable = metalLayer?.nextDrawable() else { return }
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(
            red: 0.0,
            green: 104.0/255.0,
            blue: 55.0/255.0,
            alpha: 1.0)
        
        let commandBuffer = commandQueue.makeCommandBuffer()!
        
        let renderEncoder = commandBuffer
          .makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder
            .drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    @objc func gameloop() {
        autoreleasepool {
            self.render()
        }
    }
}

final class DisplayFractalView: UIView {
    var playPressed = false
    
    private let colors: [UIColor] = [.blue, .yellow]
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if playPressed {
            let plasmaColors = PlasmaGenerator(rect: rect).plasmaFractal(roughness: 0.5)
            
            for i in stride(from: Int.zero, to: Int(bounds.width), by: 1) {
                for j in stride(from: Int.zero, to: Int(bounds.height), by: 1) {
//                    let color = colors.randomElement() ?? .red
                    let path = UIBezierPath(rect: .init(x: i, y: j, width: 1, height: 1))
                    
                    plasmaColors[i][j].set()
                    path.fill()
                }
            }
        }
    }
}

struct FractalView_Previews: PreviewProvider {
    static var previews: some View {
        FractalGenerationView(playPressed: .constant(false))
    }
}

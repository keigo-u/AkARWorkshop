//
//  ARViewContainer.swift
//  ARKitSampleTest
//
//  Created by 鵜沼慶伍 on 2023/11/13.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController
    
    @ObservedObject var viewModel: FamousQuoteViewModel
    
    func makeUIViewController(context: Context) -> ARViewController {
        ARViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {}
}

class ARViewController: UIViewController, ARSessionDelegate {
    
    private let viewModel: FamousQuoteViewModel
    private var arView: ARView!
    
    init(viewModel: FamousQuoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARView(frame: .zero)
        arView.session.delegate = self
        
        // タップ時のジェスチャーの作成、追加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        arView.addGestureRecognizer(tapGesture)
        
        self.view = arView
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        Task {
            await viewModel.fetch()
        }
        // タップ位置を取得
        let tapLocation = sender.location(in: arView)
        
        // AR空間上の座標に変換
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
        
        if let firstResult = results.first {
            let worldTransform = firstResult.worldTransform
            let tapCoordinates = SIMD3<Float>(worldTransform.columns.3.x,
                                              worldTransform.columns.3.y,
                                              worldTransform.columns.3.z)

            // ここでタップ座標を利用
            makeTextObject(cordinates: tapCoordinates)
        }
    }
    
    private func makeTextObject(cordinates: SIMD3<Float>) {
        // 名言を取得
        guard let meigen = viewModel.famousQuotes.first?.meigen else { return }
        // オブジェクトを配置する位置(アンカー)を設定
        let anchor = AnchorEntity()
        anchor.position = cordinates
        
        // anchorに名前をつける
        let anchorCount =  arView.scene.anchors.count + 1
        anchor.name = "anchor\(anchorCount)"
        
        let textMesh = MeshResource.generateText(meigen.insertLineBreak(), extrusionDepth: 0.03, font: .systemFont(ofSize: 0.05), containerFrame: CGRect.zero, alignment: .center, lineBreakMode: .byWordWrapping)
        let textMaterial = SimpleMaterial(color: UIColor.yellow, roughness: 0.0, isMetallic: true)
        let text = ModelEntity(mesh: textMesh, materials: [textMaterial])
        
        text.transform = Transform(pitch: 0, yaw: 0.3, roll: 0)
        
        anchor.addChild(text)
        arView.scene.anchors.append(anchor)
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("added!")
    }
}

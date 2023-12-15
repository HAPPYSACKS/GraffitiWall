//
//  CustomARView.swift
//  GraffitiWall
//
//  Created by Eric Mao on 2023-12-15.
//

import ARKit
import Combine
import RealityKit
import SwiftUI

class CustomARView: ARView {
    var viewModel: ImageSelectionViewModel

    init(frame frameRect: CGRect, viewModel: ImageSelectionViewModel) {
        self.viewModel = viewModel
        super.init(frame: frameRect)
        setupARSession()
        subscribeToActionStream()
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placeImage(let img):
                    print("Place image should execute?")
                    self?.placeImage(image: img)
//                    self?.placeBlueBlock()
                }
            }.store(in: &cancellable)
    }
    
//    func placeBlueBlock() {
//        let block = MeshResource.generateBox(size: 1)
//        let material = SimpleMaterial(color: .blue, isMetallic: false)
//        let
//        entity = ModelEntity(mesh: block, materials: [material])
//        let
//        anchor = AnchorEntity(plane: .horizontal)
//        anchor.addChild(entity)
//        scene.addAnchor(anchor)
//        print("Block has been placed")
//    }
    
    private func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical] // Adjust plane detection as needed.
        configuration.environmentTexturing = .automatic // Adjust this to .none if you don't want environment texturing.
        // Add any other configuration settings you may need.
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        self.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showAnchorGeometry]

        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    func placeImage(image img: UIImage) {
        // Assuming that the user interaction (tap) has provided a raycast result

        guard let raycastResult = performRaycast() else { return }
        
        
        
        
        guard let imageFromAssets = viewModel.selectedImage else { return }

        // Use imageFromAssets for your texture
        var material = UnlitMaterial(color: .white)
        guard let cgImage = imageFromAssets.cgImage else {
            print("Failed to get CGImage from UIImage")
            return
        }
        let textureResource: TextureResource
        do {
            // Create default texture creation options
            let options = TextureResource.CreateOptions(semantic: nil, mipmapsMode: .none)
            textureResource = try TextureResource.generate(from: cgImage, options: options)
        } catch {
            print("Failed to generate texture from CGImage: \(error)")
            return
        }
        
        
        
        material.baseColor = MaterialColorParameter.texture(textureResource)
        material.tintColor = UIColor(white: 1.0, alpha: 0.9999)  // Setting tintColor for transparency

        // Creating a plane mesh with the image aspect ratio
        let aspectRatio = img.size.width / img.size.height
        let planeMesh = MeshResource.generatePlane(width: 1, depth: 1 / Float(aspectRatio))
        

        // Creating a model entity with the plane mesh and the material
        let modelEntity = ModelEntity(mesh: planeMesh, materials: [material])
        

        // Creating an anchor entity at the raycast hit location
        let anchorEntity = AnchorEntity(world: raycastResult.worldTransform)
        anchorEntity.addChild(modelEntity)
        
        // Orient the entity to be perpendicular to the wall
        var orientation = simd_quaternion(raycastResult.worldTransform.columns.2)
        // Rotate 180 degrees around the y-axis if the image is upside down
        orientation = simd_mul(orientation, simd_quaternion(Float.pi, [0, 1, 0]))
        modelEntity.orientation = orientation

        // Adding the anchor entity to the scene
        self.scene.addAnchor(anchorEntity)
        
    }

    private func performRaycast() -> ARRaycastResult? {
        // Perform a raycast against the mesh or estimated plane
        print("Raycast function entered")
        guard let query = makeRaycastQuery(from: center, allowing: .estimatedPlane, alignment: .vertical) else {return nil}
        print("Raycast function execution successful")
        return session.raycast(query).first
    }
}
    
    
    

//
//  CustomARViewRepresentable.swift
//  GraffitiWall
//
//  Created by Eric Mao on 2023-12-15.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: ImageSelectionViewModel
    
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView(frame: .zero, viewModel: viewModel)
    }
    func updateUIView(_ uiView: CustomARView, context: Context) {
        if let selectedImage = viewModel.selectedImage {
            uiView.placeImage(image: selectedImage)
        }
    }
}

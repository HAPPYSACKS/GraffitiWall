//
//  ImageGridView.swift
//  GraffitiWall
//
//  Created by Eric Mao on 2023-12-16.
//

import SwiftUI
struct ImageGridView: View {
    @ObservedObject var viewModel: ImageSelectionViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.availableImages, id: \.self) { imageName in
                    if let uiImage = UIImage(named: imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                viewModel.selectedImage = uiImage
                                // Note: The grid view will be hidden by the ContentView
                            }
                    }
                }
            }
        }
    }
}

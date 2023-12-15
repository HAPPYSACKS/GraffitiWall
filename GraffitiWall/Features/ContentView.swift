//
//  ContentView.swift
//  GraffitiWall
//
//  Created by Eric Mao on 2023-12-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ImageSelectionViewModel()
    @State private var isGridViewVisible = false  // State to control visibility of the grid


    var body: some View {
            ZStack {
                CustomARViewRepresentable(viewModel: viewModel)
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    if isGridViewVisible {
                        ImageGridView(viewModel: viewModel)
                            .frame(height: 200)
                    }
                    
                    // Button to toggle the grid view
                    Button(action: {
                        isGridViewVisible.toggle()
                    }) {
                        Label("Pictures", systemImage: "photo")
                            
                    }
                    .padding()
                }
            }
            .onChange(of: viewModel.selectedImage) { _ in
                isGridViewVisible = false  // Hide the grid when an image is selected
            }
        }
}


#Preview {
    ContentView()
}

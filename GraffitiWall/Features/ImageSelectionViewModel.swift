//
//  ImageSelectionViewModel.swift
//  GraffitiWall
//
//  Created by Eric Mao on 2023-12-16.
//

import Foundation
import UIKit

class ImageSelectionViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    
    let availableImages = ["krabs", "hutao", "gigachad", "lewd", "pompompurin", "wojakcry", "thiccomniman", "ohyeahkrabs", "squidward"] // Names of images in Assets.xcassets
}

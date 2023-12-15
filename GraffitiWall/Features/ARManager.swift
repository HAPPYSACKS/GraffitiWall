//
//  ARManager.swift
//  GraffitiWall
//
//  Created by Eric Mao on 2023-12-15.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}

//
//  CameraModel.swift
//  AVFoundation_camera
//
//  Created by Mateus Rodrigues Santos on 17/08/20.
//  Copyright © 2020 Mateus Rodrigues Santos. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreML
import Vision




class Recognition{
    
    let visionModel:VNCoreMLModel?
    
    init() {
        do {
            let url = Bundle.main.path(forResource: "faceShape 1", ofType: ".mlmodel")
            let path = URL(fileURLWithPath: url!)
            try visionModel = VNCoreMLModel(for: MLModel(contentsOf: path))
        } catch {
            fatalError("Error in load vision model")
        }
    }
    
    
}

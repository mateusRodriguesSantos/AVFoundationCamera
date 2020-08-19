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

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

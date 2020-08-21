////
////  picker+predict.swift
////  DashUi
////
////  Created by christiano filipe pinto on 21/08/20.
////  Copyright © 2020 christiano filipe pinto. All rights reserved.
////
//
//import Foundation
//
//func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        let imagem = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//
//        UIGraphicsBeginImageContextWithOptions (CGSize(width: 299, height: 299), true, 2.0)
//
//        imagem!.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
//        var pixelBuffer : CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                         Int(newImage.size.width), Int(newImage.size.height),
//                                         kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
//
//        guard (status == kCVReturnSuccess) else {
//            return
//        }
//
//        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//
//        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
//
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//
//        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace,bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//
//        context?.translateBy(x: 0, y: newImage.size.height)
//
//        context?.scaleBy(x: 1.0, y: -1.0)
//
//        UIGraphicsPushContext(context!)
//
//        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
//
//        UIGraphicsPopContext()
//
//        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//
//
//        // MARK: Prediction da imagem / classificacao
//        //predict image label
////        classificacao.isHidden = false
//        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
//            classificacao.text = "Can't Predict!"
//            return
//        }
//
////        classificacao.text = "This is probably \(prediction.classLabel)."
//
//        print("This is probably \(prediction.classLabel).")
//
//        dismiss(animated: true, completion: nil)
//
//
//    }
//}

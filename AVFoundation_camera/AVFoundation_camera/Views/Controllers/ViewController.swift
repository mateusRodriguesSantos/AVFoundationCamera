//
//  ViewController.swift
//  AVFoundation_camera
//
//  Created by Mateus Rodrigues Santos on 17/08/20.
//  Copyright © 2020 Mateus Rodrigues Santos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var positionDevice:AVCaptureDevice.Position = AVCaptureDevice.Position.front
    @IBOutlet weak var segmentoBackOrFront: UISegmentedControl!
    
    //Selecting the capture session this is responsable for all gerency of the input and output devices and media captures
    let captureSession = AVCaptureSession()
//    let previewView = PreviewView(frame: CGRect(x: 20, y: 179, width: 374, height: 512))
    
    ///Layer of camera view
    var previewLayer:CALayer!
    
    ///Device
    var captureDevice:AVCaptureDevice!
    
    ///The responsable boolean that defines if I can get photo
    var takePhoto = false
    
    ///UIButton getPhoto
    @IBOutlet weak var buttonGetPhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        prepareCamera()
    }
    
    @IBAction func Triggerbuttonsegmentocontrol(_ sender: Any) {
        if segmentoBackOrFront.selectedSegmentIndex == 0{
            positionDevice = AVCaptureDevice.Position.front
            DispatchQueue.main.async {
                self.stopCaptureSession()
                self.prepareCamera()
            }
        }else{
            positionDevice = AVCaptureDevice.Position.back
            DispatchQueue.main.async {
                self.stopCaptureSession()
                self.prepareCamera()
            }
        }
    }
    
    //Trigger of the button get photo
    @IBAction func getPhoto(_ sender: Any) {
        takePhoto = true
        
    }
    
    func prepareCamera(){
        //Capture the last session or the present session
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        //search devices availables
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: positionDevice).devices
        
        //Choose the first device in matrix
        captureDevice = availableDevices.first
        
        beginSession()
        
    }
    
    //Fuction for begining the session of the photo capture
    func beginSession(){
        //Configuring input device
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(captureDeviceInput)
        }catch{
            print(error.localizedDescription)
        }
        
        //Configuring the layer that show video in real time
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        captureSession.startRunning()
        
        //Configuring the output
        ///The data output is responsable at set an image
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String):NSNumber(value: kCVPixelFormatType_32BGRA)]
        
        //Discard frames video that arrive late
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        //Add data output in capture session
        if captureSession.canAddOutput(dataOutput){
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        //Create a queue for buffer delegate of dataOutput
        let queue = DispatchQueue(label: "can.brianAndCapture.captureQueue")
        //Setting the buffer delegate, delegate is this view controller
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    //Function of the capture output
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if takePhoto{
            
            takePhoto = false
            //getImageFromSampleBuffer
            
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer){
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
             
                DispatchQueue.main.async {
                    self.alertSaved()
                    self.stopCaptureSession()
                    self.prepareCamera()
                }
            }
         
        }
    }
    
    func alertSaved(){
        let alert = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
        }
        
        let alertController = UIAlertController(title: "Photo Library", message: "Photo saved at your photo library", preferredStyle: .alert)
        alertController.addAction(alert)
        
        self.present(alertController, animated: false, completion: nil)
    }
    
    func getImageFromSampleBuffer(buffer:CMSampleBuffer) -> UIImage?{
        
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer){
            let cImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let imageRect = context.createCGImage(cImage, from: imageRect){
                
                return UIImage(cgImage: imageRect, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        return nil
    }
    
    //Stop session and remove all input devices
    func stopCaptureSession(){
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput]{
            for input in inputs{
                captureSession.removeInput(input)
            }
        }
    }

}


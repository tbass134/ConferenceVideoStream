//
//  PublishEventViewController.swift
//  ConferenceStreaming
//
//  Created by Tony Hung on 6/6/16.
//  Copyright © 2016 Vonage. All rights reserved.
//

import Foundation

class PublishEventViewController: R5VideoViewController, R5StreamDelegate {

    var config:R5Configuration?
    var stream:R5Stream?
    
    override func viewDidLoad() {
        config = R5Configuration()
        config?.host = "52.39.78.161"
        config?.port = 8554
        config?.contextName = "live"
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.stop()
        super.viewDidDisappear(animated)
    }
    
    
    func preview() {
        let cameras = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        let cameraDevice:AVCaptureDevice = cameras.last as! AVCaptureDevice
        let camera = R5Camera(device: cameraDevice, andBitRate: 512)
        camera.orientation = 90
        
        
        let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        let mic = R5Microphone(device: audioDevice)
        
        let connection = R5Connection(config: config)
        stream = R5Stream(connection: connection)
        stream?.attachVideo(camera)
        stream?.attachAudio(mic)
        stream?.delegate = self
        self.attachStream(stream)
        self.showPreview(true)
    }
    
    func start(name:String? = red5prostream) {
        self.preview()
        self.showPreview(false)
        stream?.publish(name, type: R5RecordTypeLive)
    }

    func stop() {
        stream?.stop()
        stream?.delegate = nil
        self.preview()
    }
    
    func onR5StreamStatus(stream: R5Stream!, withStatus statusCode: Int32, withMessage msg: String!) {
        print("Stream \(r5_string_for_status(statusCode)) message \(msg)" )
    }

}



//
//  VideoViewController.swift
//  ConferenceStreaming
//
//  Created by Tony Hung on 6/6/16.
//  Copyright © 2016 Vonage. All rights reserved.
//

import Foundation

class VideoViewController: UIViewController {

    var publisher:PublishEventViewController?
    var isPublishing = false
    
    @IBOutlet weak var startVideoButton: UIButton!
    
    override func viewDidLoad() {
        publisher = self.storyboard?.instantiateViewControllerWithIdentifier("PublishEventVC") as? PublishEventViewController
        
        publisher!.view.layer.frame = self.view.bounds
        
        self.view.addSubview(publisher!.view)
        self.view.sendSubviewToBack(publisher!.view)
        publisher?.preview()
        startVideoButton.setTitle("Start", forState: .Normal)

        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        if !isPublishing {
            let uuid: String = NSUUID().UUIDString
            publisher?.start(uuid)
            let video = (Video(videoID: nil, title: "My New Video", date: NSDate(), url: NSURL(string: "http://ec2-52-39-78-161.us-west-2.compute.amazonaws.com/live/streams/\(uuid)")!))
            ServiceManager.sharedManager.addVideo(video, completionBlock: { (results, error) in
                if error == nil {
                    print("success")
                }
            })
            startVideoButton.setTitle("Stop", forState: .Normal)
            isPublishing = true
        } else {
            startVideoButton.setTitle("Start", forState: .Normal)
            publisher?.stop()
            isPublishing = false
        }
    }
}

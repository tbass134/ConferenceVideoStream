//
//  ViewController.swift
//  ConferenceStreaming
//
//  Created by Tony Hung on 5/6/16.
//  Copyright © 2016 Vonage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = ServiceManager.sharedManager
//        let video = Video(videoID: nil, title: "My New Video", date: NSDate(), url: NSURL(string: "http://myvideo1.rtsp")!)
//        manager.addVideo(video) { (results, error) in
//            print(error)
//            print(results)
//        }
        manager.loadItems { (results, error) in
//            print(results)
        }

        
    }
    
    func lambda() {
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


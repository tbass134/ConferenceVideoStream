//
//  ServiceManager.swift
//  ConferenceStreaming
//
//  Created by Tony Hung on 6/6/16.
//  Copyright © 2016 Vonage. All rights reserved.
//

import Foundation

typealias CompletionBlock = (results: AnyObject?, error:NSError?) -> ()

struct Video {
    let videoID:String?
    let title:String
    let date:NSDate
    let url:NSURL
}
class ServiceManager {
    static let sharedManager = ServiceManager()

    lazy var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()

        let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.locale = enUSPosixLocale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    private init() {
        
       
    }
    
    func loadItems(operation:String = "read", id:String = "*", completionBlock:CompletionBlock) {
        
           }
    
    func addVideo(video:Video, completionBlock:CompletionBlock) {
         }
}
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
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1,
                                                                identityPoolId:"us-east-1:473cd8fa-777e-4d74-926d-ea4438e7d92a")
        
        let configuration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration

    }
    
    func loadItems(operation:String = "read", id:String = "*", completionBlock:CompletionBlock) {
        
        let lambdaInvoker = AWSLambdaInvoker.defaultLambdaInvoker()
        let params = ["operation":operation, "id":id]
        lambdaInvoker.invokeFunction("ConferenceVideoBackend", JSONObject: params) { (results, error) in
            
            var list = [Video]()
            
            if let videos = results as? Array<Dictionary<String, String>>{
                for data in videos {
                   list.append(Video(videoID: data["id"], title: data["title"]!, date: NSDate.sam_dateFromISO8601String(data["date"]!), url: NSURL(string: data["url"]!)!))
                }
            }
            print(list)
            completionBlock(results: results, error: error)
            
        }
    }
    
    func addVideo(video:Video, completionBlock:CompletionBlock) {
        let lambdaInvoker = AWSLambdaInvoker.defaultLambdaInvoker()
        let params = ["operation":"create", "title":video.title, "url":video.url.absoluteString]
        lambdaInvoker.invokeFunction("ConferenceVideoBackend", JSONObject: params) { (results, error) in
            completionBlock(results: results, error: error)
            
        }
    }
}
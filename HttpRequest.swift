//
//  HttpRequest.swift
//  GeoLocation
//
//  Created by Ziyun Wang on 8/7/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation
import CoreLocation

class requestSender {
    
    func sendRequest(urlstring: String, postString: String){
        //build the url request
        let urlPath: String = urlstring
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        var stringToPost = postString
        //        let stringToPost = "json=%5B%7B%22time%22%3A%220%22%2C%22sport%22%3A%220%22%2C%22intensity%22%3A%220%22%2C%22duration%22%3A%220%22%7D%5D&uuid=zw21&data_type=owlympics"
        let body_data = stringToPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        //set the request header
        let body_length = body_data!.length
        let body_len_str = String(body_length)
        
        request.setValue(body_len_str, forHTTPHeaderField: "Content-Length")
        request.setValue("Basic bHVjeTpyZXNlYXJjaHByb2plY3Q=", forHTTPHeaderField: "Authorization")
        //customize all the other header fields.
        
        //configure the requests and build the HTTP body
        request.timeoutInterval = 60
        request.HTTPBody = body_data
        request.HTTPShouldHandleCookies = false
        //build the request body
        
        let queue:NSOperationQueue = NSOperationQueue()
        //send request and handle errors
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
        })
        println("request sent successfully")
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
    { //It says the response started coming
        NSLog("didReceiveResponse")
    }
    

    
    func buildRequestFromStringsAndSend(timeString: String, durationString: String, sportString: String, locationString: String,
        intensityString: String, uuidString: String, urlString: String){
            
            let UUIDField = "uuid=" + uuidString
            let dataTypeField = "data_type=owlympics"
            
            let fields = "json=[{\"time\":\"" + timeString + "\",\"sport\":\"" + sportString + "\",\"intensity\":\"" + intensityString + "\",\"duration\":\"" + durationString + "\"}]"
            
            let fields_encode = fields.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            //println(fields_encode)
            let body = fields_encode! + "&" + UUIDField + "&" + dataTypeField
            
            sendRequest(urlString, postString: body)
    }
    
}
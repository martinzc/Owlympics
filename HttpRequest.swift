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
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        let stringToPost = postString
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
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            var _: NSError
        })
        print("request sent successfully")
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
    
    
    func buildGetRequestAndSend(uuid: String, urlString: String) {
        let UUIDField = "uuid=" + uuid;
        let typeField = "type=" + "retrieve"
        let body = UUIDField + "&" + typeField
//        Martin edited on Dec4. Following function is not returning anything
//        let feedBack = sendGetRequestAndReturn(uuid, urlString: urlString, body: body)
//        print(feedBack, terminator: "")
        sendGetRequestAndReturn(uuid, urlString: urlString, body: body)
    }
    
    
    func sendGetRequestAndReturn (UUID: String, urlString: String, body: String){
        let urlPath: String = urlString;
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        let body_data = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        //set the request header
        //let body_length = body_data!.length
        //let body_len_str = String(body_length)
        
        //request.setValue(body_len_str, forHTTPHeaderField: "Content-Length")
        request.setValue("Basic bHVjeTpyZXNlYXJjaHByb2plY3Q=", forHTTPHeaderField: "Authorization")
        //customize all the other header fields.
        
        //configure the requests and build the HTTP body
        request.timeoutInterval = 60
        request.HTTPBody = body_data
        request.HTTPShouldHandleCookies = false
        //build the request body
        
        let queue:NSOperationQueue = NSOperationQueue()
        var _:NSData
        //send request and handle errors
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            var _: NSError
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(result)
        })
        print("request sent successfully")
    }
    
}
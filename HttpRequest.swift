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
    
    //time
    func timeStringBuilder(dateInfo: NSDate)->String{
        //get all the date information
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        return "time=" + formatter.stringFromDate(dateInfo)
        
    }
    //duration
    func durationStringBuilder(dura: Int64) -> String{
        return "duration=" + String(dura);
    }
    //sport
    func sportStringBuilder(sport: String)->String{
        return "sport=" + sport
    }
    //location
    func locStringBuilder(loc: CLLocationCoordinate2D) -> String{
        let locStr = "(\(loc.latitude),\(loc.longitude))"
        return "location=" + locStr
    }
    //intensity
    func intStringBuilder(intensity: Int)->String{
        return "intensity=" + String(intensity)
    }
    //UUID
    func UUIDBuilder(UUID: Int)->String{
        return "UUID=" + String(UUID);
    }
    
    
    func requestSender(urlstring: String, postString: String){
        //build the url request
        let urlPath: String = urlstring
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        var stringToPost = postString
        let body_data = stringToPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        //set the request header
        let body_length = body_data!.length
        let body_len_str = String(body_length)
        
        request.setValue("OwlympicsData", forHTTPHeaderField: "Content-Type")
        request.setValue(body_len_str, forKey: "Content-Length")
        
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
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            println("AsSynchronous\(jsonResult)")
        })
    }
    
    func buildRequestAndSend(dateInfo: NSDate, duration: Int64, sport: String, location: CLLocationCoordinate2D,
        intensity: Int, uuid: Int, urlString: String){
            //build the request body when the parameters are given as their original types
            let timeField = timeStringBuilder(dateInfo)
            let durationField = durationStringBuilder(duration)
            let sportField = sportStringBuilder(sport)
            let locationField = locStringBuilder(location)
            let intensityField = intStringBuilder(intensity)
            let UUIDField = UUIDBuilder(uuid)
            
            let body = UUIDField + "&" + timeField + "&" + durationField + "&" + sportField + "&" + locationField
                + "&" + intensityField
            requestSender(urlString, postString: body)
            
    }
    
    func buildRequestFromStringsAndSend(timeString: String, durationString: String, sportString: String, locationString: String,
        intensityString: String, uuidString: String, urlString: String){
            //build the request body when the parameters are given as formated strings
            let timeField = "time=" + timeString
            let durationField = "duration=" + durationString
            let sportField = "sport=" + sportString
            let locationField = "location=" + locationString
            let intensityField = "intensity=" + intensityString
            let UUIDField = "UUID=" + uuidString
            
            let body = UUIDField + "&" + timeField + "&" + durationField + "&" + sportField + "&" + locationField
                + "&" + intensityField
            requestSender(urlString, postString: body)
    }
    
    
}
//
//  Exercise.swift
//  owlympics
//
//  Created by Martin Zhou on 8/13/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

/* Defines the structure for exercise objects */

import Foundation

class Exercise:NSObject {
    
//    Initialize variables
    var arrivaltime: NSDate
    var duration: String
    var sport: String
    var intensity: String
    
    init(tim: NSDate, dur: String, spo: String, inten: String){
        self.arrivaltime = tim
        self.duration = dur
        self.sport = spo
        self.intensity = inten
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(duration, forKey:"duration")
        aCoder.encodeObject(intensity, forKey:"intensity")
        aCoder.encodeObject(arrivaltime, forKey:"arrivaltime")
        aCoder.encodeObject(sport, forKey:"sport")
    }
    
    init(coder aDecoder: NSCoder!) {
        
        duration = aDecoder.decodeObjectForKey("duration") as! String
        intensity = aDecoder.decodeObjectForKey("intensity") as! String
        arrivaltime = aDecoder.decodeObjectForKey("arrivaltime") as! NSDate
        sport = aDecoder.decodeObjectForKey("sport")as! String
        
    }
}

struct defaultsKeys {
    static let keyDict = "DictionaryOfExercise" // Where an array of exercise is stored
    static let keyVisit = "TimeOfVisits" // Where an array of visits is stored
}


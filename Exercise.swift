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
    var user_input: Bool    // True if the user input it manually and false if it is computer detected
    
    init(tim: NSDate, dur: String, spo: String, inten: String, userInput: Bool){
        self.arrivaltime = tim
        self.duration = dur
        self.sport = spo
        self.intensity = inten
        self.user_input = userInput
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(duration, forKey:"duration")
        aCoder.encodeObject(intensity, forKey:"intensity")
        aCoder.encodeObject(arrivaltime, forKey:"arrivaltime")
        aCoder.encodeObject(sport, forKey:"sport")
        aCoder.encodeObject(user_input, forKey:"userInput")
    }
    
    init(coder aDecoder: NSCoder!) {
        
        duration = aDecoder.decodeObjectForKey("duration") as! String
        intensity = aDecoder.decodeObjectForKey("intensity") as! String
        arrivaltime = aDecoder.decodeObjectForKey("arrivaltime") as! NSDate
        sport = aDecoder.decodeObjectForKey("sport")as! String
        user_input = aDecoder.decodeObjectForKey("userInput")as! Bool
        
    }
}

struct defaultsKeys {
    static let keyDict = "DictionaryOfExercise" // Where an array of exercise is stored
    static let keyVisit = "TimeOfVisits" // Where an array of visits is stored
}


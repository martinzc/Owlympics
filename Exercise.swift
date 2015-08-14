//
//  Exercise.swift
//  owlympics
//
//  Created by Martin Zhou on 8/13/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation

class Exercise:NSObject {
    var time: String
    var duration: Int
    var sport: String
    var intensity: Int
    
    init(tim: String, dur: Int, spo: String, inten: Int){
        self.time = tim
        self.duration = dur
        self.sport = spo
        self.intensity = inten
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeInteger(duration, forKey:"duration")
        aCoder.encodeInteger(intensity, forKey:"intensity")
        aCoder.encodeObject(time, forKey:"time")
        aCoder.encodeObject(sport, forKey:"sport")
    }
    
    init(coder aDecoder: NSCoder!) {
        
        duration = aDecoder.decodeIntegerForKey("duration")
        intensity = aDecoder.decodeIntegerForKey("intensity")
        time = aDecoder.decodeObjectForKey("time") as! String
        sport = aDecoder.decodeObjectForKey("sport")as! String
        
    }
}

struct defaultsKeys {
    static let keyIndex = "IndexOfInput"
    static let keyDict = "DictionaryOfExercise"
}


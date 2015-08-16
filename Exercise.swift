//
//  Exercise.swift
//  owlympics
//
//  Created by Martin Zhou on 8/13/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation

class Exercise:NSObject {
    var arrivaltime: String
    var duration: String
    var sport: String
    var intensity: String
    
    init(tim: String, dur: String, spo: String, inten: String){
        self.arrivaltime = tim
        self.duration = dur
        self.sport = spo
        self.intensity = inten
    }
    
    func storeToLocal() {
        // Initialize data storage
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let dictOfExercise = defaults.valueForKey(defaultsKeys.keyDict) as? NSData {
            var allExercise = NSKeyedUnarchiver.unarchiveObjectWithData(dictOfExercise) as! [Exercise]
            allExercise.append(self)
            let exerciseData = NSKeyedArchiver.archivedDataWithRootObject(allExercise)
            defaults.setValue(exerciseData, forKey: defaultsKeys.keyDict)
        } else {
            var allExercise = [Exercise]()
            allExercise.append(self)
            let exerciseData = NSKeyedArchiver.archivedDataWithRootObject(allExercise)
            defaults.setValue(exerciseData, forKey: defaultsKeys.keyDict)
        }
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
        arrivaltime = aDecoder.decodeObjectForKey("arrivaltime") as! String
        sport = aDecoder.decodeObjectForKey("sport")as! String
        
    }
}

struct defaultsKeys {
    static let keyDict = "DictionaryOfExercise" // Where an array of exercise is stored
}


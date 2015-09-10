//
//  LocalStorage.swift
//  owlympics
//
//  Created by Martin Zhou on 9/9/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation

    
func storeToLocal(exercisefile:Exercise) {
    //        Initialize data storage
    //        Create user default delegate
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if let dictOfExercise = defaults.valueForKey(defaultsKeys.keyDict) as? NSData {
        var allExercise = NSKeyedUnarchiver.unarchiveObjectWithData(dictOfExercise) as! [Exercise]
        allExercise.append(exercisefile)
        let exerciseData = NSKeyedArchiver.archivedDataWithRootObject(allExercise)
        defaults.setValue(exerciseData, forKey: defaultsKeys.keyDict)
    } else {
        var allExercise = [Exercise]()
        allExercise.append(exercisefile)
        let exerciseData = NSKeyedArchiver.archivedDataWithRootObject(allExercise)
        defaults.setValue(exerciseData, forKey: defaultsKeys.keyDict)
    }
}

func loadFromLocal() -> [Exercise] {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var allExercise: [Exercise] = []
    
    if let dictOfExercise = defaults.valueForKey(defaultsKeys.keyDict) as? NSData {
        var allExercise = NSKeyedUnarchiver.unarchiveObjectWithData(dictOfExercise) as! [Exercise]
    }
    
    return allExercise
}

func durationOfPastSevenDays() -> [Int] {
    
    var durationList = [0, 0, 0, 0, 0, 0, 0]
    
//    Load local data
    let exerciseList = loadFromLocal()
    
//    Update the durationList according to localData
    for eachExercise:Exercise in exerciseList {
//        Get the two times
        let exerciseTime = eachExercise.arrivaltime
        let currentTime = NSDate()
        
//        Calculate the days between the two times
        let daysBetween = calculateDaysBetween(exerciseTime, currentTime)
        
//        Add the duration to that day if it's within six days
        if daysBetween < 7 {
            let dur:Int! = eachExercise.duration.toInt()
            durationList[durationList.count - 1 - daysBetween] += dur
        }
    }
    
    return durationList
}
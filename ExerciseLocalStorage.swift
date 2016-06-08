//
//  LocalStorage.swift
//  owlympics
//
//  Created by Martin Zhou on 9/9/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation

// Store exercise object to local
func storeToLocal(exercisefile:Exercise) {
    //        Initialize data storage
    //        Create user default delegate
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if let dictOfExercise = defaults.valueForKey(defaultsKeys.keyDict) as? NSData {
        var allExercise = NSKeyedUnarchiver.unarchiveObjectWithData(dictOfExercise) as! [Exercise]
        allExercise.append(exercisefile)
//        println("there is data in local storage")
//        println(allExercise)
        let exerciseData = NSKeyedArchiver.archivedDataWithRootObject(allExercise)
        defaults.setValue(exerciseData, forKey: defaultsKeys.keyDict)
    } else {
        var allExercise = [Exercise]()
        allExercise.append(exercisefile)
        print("there is not data in local storage", terminator: "")
//        println(allExercise)
        let exerciseData = NSKeyedArchiver.archivedDataWithRootObject(allExercise)
        defaults.setValue(exerciseData, forKey: defaultsKeys.keyDict)
    }
//    println("successfully stored data")
}

// Load list of exercise file that is stored in local memory
func loadFromLocal() -> [Exercise] {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var allExercise: [Exercise] = []
    
    if let dictOfExercise = defaults.valueForKey(defaultsKeys.keyDict) as? NSData {
        allExercise = NSKeyedUnarchiver.unarchiveObjectWithData(dictOfExercise) as! [Exercise]
//        println("Successfully Loaded Data")
//        println(allExercise)
    }
//    println(allExercise)
    return allExercise
}

// Get the duration of the user being in the gym in the past seven days
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
        let daysBetween = calculateDaysBetween(exerciseTime, date2: currentTime)
        
//        Add the duration to that day if it's within six days
        if daysBetween < 7 {
            let dur:Int! = Int(eachExercise.duration)
            durationList[durationList.count - 1 - daysBetween] += dur
        }
    }
    
    return durationList
}

// Get the number of times the user visisted the gym in the past seven days
func visitOfPastSevenDays() -> Int {
    
    var visit = 0;
    //    Load local data
    if let exerciseList = loadListFromLocal(defaultsKeys.keyVisit) as [NSDate]! {
        for exerciseTime:NSDate in exerciseList {
            //        Get the two times
            let currentTime = NSDate()
            
            //        Calculate the days between the two times
            let daysBetween = calculateDaysBetween(exerciseTime, date2: currentTime)
            
            //        Add the duration to that day if it's within six days
            if daysBetween < 7 {
                visit += 0
            }
        }
    }
    
    //    Update the durationList according to localData
    
    
    return visit
}

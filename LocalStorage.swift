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
   
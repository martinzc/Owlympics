//
//  Workout.swift
//  owlympics
//
//  Created by Martin Zhou on 8/12/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

var allWorkout:[Workout] = []
var currentIndex:Int = -1
var workoutTable:UITableView?

class Workout: NSObject {
    
    var entryDate: String?
    var exitDate: String?
    var longitude: Double?
    var latitude: Double?
    var sport: String?
    var intensity: Int?
    var duration: Double?
    var uuid: Int?
    
    override init() {
    }
    
    func dictionary() {
        return ["entryDate":entryDate, "exitDate":exitDate, "longitude":longitude, "latitude":latitude, "sport":sport, "intensity":intensity, "duration":duration, "uuid":uuid]
    }
    
    
    
    
   
}

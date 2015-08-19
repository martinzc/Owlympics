//
//  TodayViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 7/27/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDataSource, GMBLCommunicationManagerDelegate, GMBLPlaceManagerDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell_select = tableView.dequeueReusableCellWithIdentifier("summary_select", forIndexPath: indexPath) as! UITableViewCell
            cell_select.textLabel!.text = "workout summaries"
            return cell_select
        }
        else if indexPath.row == 1 {
            let cell_select = tableView.dequeueReusableCellWithIdentifier("history_select", forIndexPath: indexPath) as! UITableViewCell
            cell_select.textLabel!.text = "detailed history"
            return cell_select
        }
        else {
            let cell = UITableViewCell()
            return cell
        }
    }
    
    var placeManager: GMBLPlaceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        placeManager = GMBLPlaceManager()
        placeManager.delegate = self
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) {
        println("The user visited \(visit.place.name) at \(visit.arrivalDate)")
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) {
        println("The user exited \(visit.place.name) at \(visit.departureDate)")
        
        //        Claude
        //        Here we need a notification asking whether he want to log in the exercise or not. He can then choose the sport and intensity.
        
        // If he choose yes, create a new exercise
        
        let arrivaltime:String = visit.arrivalDate.description
        var newExercise = Exercise(tim: arrivaltime, dur: "User Input", spo: "User Input", inten: "User Input")
        newExercise.storeToLocal()

    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


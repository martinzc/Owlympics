//
//  TodayViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 7/27/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDataSource, GMBLCommunicationManagerDelegate, GMBLPlaceManagerDelegate {
    
    @IBOutlet weak var graphView: GraphView!
    // label outlets
    
    @IBOutlet weak var AverageTime: UILabel!
    
    @IBOutlet weak var maxLabel: UILabel!
    
    func setupGraphDisplay() {
        
        //Use 7 days for graph - can use any number,
        //but labels and sample data are set up for 7 days
        let noOfDays:Int = 7
        
        //1 - replace last day with today's actual data
//        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(maxElement(graphView.graphPoints))"
        
        //3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, combine: +)
            / graphView.graphPoints.count
        AverageTime.text = "\(average)"
        
        //set up labels
        //day of week labels are set up in storyboard with tags
        //today is last day of the array need to go backwards
        
        //4 - get today's day number
        let dateFormatter = NSDateFormatter()
        let calendar = NSCalendar.currentCalendar()
        let componentOptions:NSCalendarUnit = .CalendarUnitWeekday
        let components = calendar.components(componentOptions,
            fromDate: NSDate())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "TH", "F"]
        
        //5 - set up the day name labels with correct day
        for i in reverse(1...days.count) {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday--]
                if weekday < 0 {
                    weekday = days.count - 1
                }
            }
        }
    }
    
    
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
        setupGraphDisplay()
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


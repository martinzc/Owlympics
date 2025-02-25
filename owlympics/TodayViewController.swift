//
//  TodayViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 7/27/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion

class TodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GMBLPlaceManagerDelegate {
    
    // view outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var graphView: GraphView!
    
    // label outlets
    
    @IBOutlet weak var AverageTime: UILabel!
    
    @IBOutlet weak var maxLabel: UILabel!
    
    
    var placeManager: GMBLPlaceManager!

    func setupGraphDisplay() {
        
        //Use 7 days for graph - can use any number,
        //but labels and sample data are set up for 7 days
//        _:Int = 7
        
        //1 - replace last day with today's actual data
//        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(Int(graphView.graphPoints.maxElement()!))"
        
//        //3 - calculate average from graphPoints
//        let average = Double(graphView.graphPoints.reduce(0, combine: +)) / Double(graphView.graphPoints.count)
//        let average_rounded = Double(round(100*average)/100)
//        AverageTime.text = "\(average_rounded) Mins per day"
        
//        Calculate the visit of the last 7 days
        AverageTime.text = "\(visitOfPastSevenDays()) visits"
        
        
        //set up labels
        //day of week labels are set up in storyboard with tags
        //today is last day of the array need to go backwards
        
        //4 - get today's day number
        _ = NSDateFormatter()
        let calendar = NSCalendar.currentCalendar()
        let componentOptions:NSCalendarUnit = .Weekday
        let components = calendar.components(componentOptions,
            fromDate: NSDate())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "TH", "F"]
        
        //5 - set up the day name labels with correct day
        for i in Array((1...days.count).reverse()) {
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
    
    @IBAction func DemoNotification(sender: AnyObject) {
        registerForegroundNotificationForInput(self)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell_select = tableView.dequeueReusableCellWithIdentifier("summary_select", forIndexPath: indexPath) 
            cell_select.textLabel!.text = "Summaries"
            return cell_select
        }
        else if indexPath.row == 1 {
            let cell_select = tableView.dequeueReusableCellWithIdentifier("history_select", forIndexPath: indexPath) 
            cell_select.textLabel!.text = "Workout History"
            return cell_select
        }
        else {
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    override func viewDidLoad() {
        
        // Hide the back button on home screen
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tableView.tableFooterView = UIView()
        
        super.viewDidLoad()
        // Set up for iBeacon
        placeManager = GMBLPlaceManager()
        placeManager.delegate = self
        storeDataToLocal("No entry time available", key: "visitStart");
        
        //Create the fitness graph
        setupGraphDisplay()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
//        Show a Sign-in page if the user has not signed in yet
        print("view is appearing")
        if GPPSignIn.sharedInstance().userEmail == nil {
            print("can't load account")
            self.performSegueWithIdentifier("ShowLogin", sender: self)
        }   
        graphView.setNeedsDisplay()
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) {
        print("The user visited \(visit.place.name) at \(visit.arrivalDate)")
        registerForegroundNotificationForAny(self, message: "Alert", title: "You've entered the gym")
        registerBackgroundNotificationForAny("Open the app", message: "You've entered the gym")
        storeDataToLocal(NSDate().description, key: "visitStart")
        
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) {
        print("The user exited \(visit.place.name) at \(visit.departureDate)")
        registerBackgroundNotification()
        registerForegroundNotificationForInput(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        if (segue.identifier == "userInputData") {
            let svc = segue.destinationViewController as! InputViewController;
            svc.userInput = true
        }
        
        else if (segue.identifier == "ShowInput") {
            let svc = segue.destinationViewController as! InputViewController;
            svc.userInput = false
            _ = GPPSignIn.sharedInstance().userEmail
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "userInputData" {
            
            let uuidString = GPPSignIn.sharedInstance().userEmail
            
            if (uuidString == nil) {
                
                let alert = UIAlertView()
                alert.title = "Warning"
                alert.message = "You need to sign in before inputting data"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
                
            else {
                return true
            }
        }
        
        // by default, transition
        return true
    }
    

}


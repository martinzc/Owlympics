//
//  SummaryViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 8/18/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit


class SummaryViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var visitLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseArray: [Exercise] = []
    
    var dataObject: AnyObject?
    var visitText: String?
    var activityText: String?
    var minText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            self.dataLabel!.text = obj.description
        } else {
            self.dataLabel!.text = ""
        }
        visitLabel.text = visitText
        activityLabel.text = activityText
        minLabel.text = minText
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if exerciseArray.count != 0 {
            return exerciseArray.count
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Detailed Information"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseInSummary", forIndexPath: indexPath) 
        
        // Configure the cell...
        if exerciseArray.count != 0{
            let event = exerciseArray[exerciseArray.count-1-indexPath.row]
            cell.textLabel?.text = getExactDay(event.arrivaltime)
            
            
            var input_source: String!
            
            if event.user_input == true {
                input_source = "Not Verified"
            }
            else {
                input_source = "Verified"
            }
            
            cell.detailTextLabel?.text = input_source + "  " + event.sport + " for " + event.duration + " mins."
            if let sport_image = UIImage(named: event.sport) {
                cell.imageView?.image = sport_image
            }
            
            return cell
        }
        else {
            cell.textLabel?.text = "None"
            cell.detailTextLabel?.text = "No verified data of you going to the Gym this month"
            return cell
        }
    }
    
    
}

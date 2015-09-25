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
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseInSummary", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        if exerciseArray.count != 0{
            let event = exerciseArray[exerciseArray.count-1-indexPath.row]
            cell.textLabel?.text = getExactDay(event.arrivaltime)
            cell.detailTextLabel?.text = event.sport + " for " + event.duration
            if let sport_image = UIImage(named: event.sport) {
                cell.imageView?.image = sport_image
            }
            
            return cell
        }
        else {
            cell.textLabel?.text = "You didn't go to the gym this month"
            return cell
        }
    }
    
    
}

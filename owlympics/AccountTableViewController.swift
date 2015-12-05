//
//  AccountTableViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 8/18/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit
import MessageUI
class AccountTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let indexAccount = NSIndexPath(forRow: 0, inSection: 0)
        let cellAccount = self.tableView(self.tableView, cellForRowAtIndexPath: indexAccount)
        cellAccount.textLabel?.text = GPPSignIn.sharedInstance().userEmail
        if(cellAccount.textLabel?.text == nil){
            cellAccount.textLabel?.text = "Sign in"
        }
        let indexLogOut = NSIndexPath(forRow: 1, inSection: 0)
        let cellLogOut = self.tableView(self.tableView, cellForRowAtIndexPath: indexLogOut)
        cellLogOut.textLabel?.text = "Log Out"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "account_detail1")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "account_detail2")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //self.tableView.registerClass(UITableView.self, forHeaderFooterViewReuseIdentifier: "account_detail")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("account_detail", forIndexPath: indexPath) 
            print(cell.textLabel?.text)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("account_detail1", forIndexPath: indexPath) 
            cell.textLabel?.text = "Give us FeedBack!"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("account_detail2", forIndexPath: indexPath) 
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Account"
        }
        else if section == 1 {
            return "Action"
        }
        else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0 && indexPath.section == 1) {
            if(MFMailComposeViewController.canSendMail()){
                let emailTitle = "FeedBack for Owlympics"
                let toRecipient = ["owlympics.feedback@gmail.com"]
                let mc:MFMailComposeViewController = MFMailComposeViewController()
            
                mc.mailComposeDelegate = self
                mc.setSubject(emailTitle)
                mc.setToRecipients(toRecipient)
            
                self.presentViewController(mc, animated: true, completion: nil)
            }else{
                print("No email found")
            }
        }
        if(indexPath.row == 1 && indexPath.section == 0) {
            GPPSignIn.sharedInstance().signOut()
            let indexAccount = NSIndexPath(forRow: 0, inSection: 0)
            let accountCell = tableView.cellForRowAtIndexPath(indexAccount)! as UITableViewCell
            accountCell.textLabel?.text = "Sign in"
        }
        if(indexPath.row == 0 && indexPath.section == 0) {
            let accountCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
            if (accountCell.textLabel?.text == "Sign in"){
                self.performSegueWithIdentifier("toLogin", sender: self)
            }
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
            case MFMailComposeResultCancelled.rawValue:
                print("Mail Cancelled")
            case MFMailComposeResultSaved.rawValue:
                print("Mail Saved")
            case MFMailComposeResultSent.rawValue:
                print("Mail Sent")
            case MFMailComposeResultFailed.rawValue:
                print("Mail Failed")
            default:
                break
        }
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */


}

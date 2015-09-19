//
//  NavigationViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 9/19/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if (loadFromLocal("First Time") != nil) {
            //        Check for notification settings, if there is no permission, send a notification
            let currentSettings = UIApplication.sharedApplication().currentUserNotificationSettings()
            let required:UIUserNotificationType = UIUserNotificationType.Sound | UIUserNotificationType.Alert; // Add other permissions as required
            if (currentSettings.types & required) == nil {
                let message = "For your better user experience. Please turn it on in <Settings>."
                let title = "Notifications are disabled"
                registerForegroundNotificationForAny(self, message, title)
            }
        }
        
        storeDataToLocal("Not first time", "First Time")
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

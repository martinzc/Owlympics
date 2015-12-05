//
//  RegisterNotification.swift
//  owlympics
//
//  Created by Martin Zhou on 9/11/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation

func registerForegroundNotificationForInput(viewController:UIViewController) {
    //        Foreground notification
    let alert = UIAlertController(title: "Alert", message: "You've exited the gym, do you want to input your exercise data?", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Input data", style: UIAlertActionStyle.Default, handler:{ (_) -> Void in
        viewController.performSegueWithIdentifier("ShowInput", sender: viewController)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:nil))
    viewController.parentViewController!.presentViewController(alert, animated: true, completion: nil)
    
}

func registerForegroundNotificationForAny(viewController:UIViewController, message: String, title: String) {
//    println("success")
    //        Foreground notification
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:nil))
    viewController.presentViewController(alert, animated: true, completion: nil)
}

func registerBackgroundNotification() {
    //        Background notification
    let localNotification:UILocalNotification = UILocalNotification()
//
    localNotification.alertAction = "Input"
    localNotification.alertBody = "You've exited the gym, do you want to input your exercise data?"
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    
}

func registerBackgroundNotificationForAny(action: String, message: String) {
    //        Background notification
    let localNotification:UILocalNotification = UILocalNotification()
    //
    localNotification.alertAction = action
    localNotification.alertBody = message
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    
}
//
//  HistoryViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 8/12/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, GMBLPlaceManagerDelegate {
    
    var placeManager: GMBLPlaceManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        placeManager = GMBLPlaceManager()
        placeManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) {
        var exercise:Workout = Workout()
        exercise.entryDate = visit.arrivalDate.description
        
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) {
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

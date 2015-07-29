//
//  FirstViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 7/27/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, GMBLCommunicationManagerDelegate, GMBLPlaceManagerDelegate {
    
    var placeManager: GMBLPlaceManager!
    var commManager: GMBLCommunicationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        placeManager = GMBLPlaceManager()
        placeManager.delegate = self
        
        commManager = GMBLCommunicationManager()
        commManager.delegate = self
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) {
        println("The user visited \(visit.place.name) at \(visit.arrivalDate)")
        
        let atts = visit.place.attributes as GMBLAttributes
        let attKeys = atts.allKeys()
        for attkey in attKeys {
            println("\(attkey): \(atts.stringForKey(attkey as! String))")
        }
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) {
        println("The user exited \(visit.place.name) at \(visit.departureDate)")
    }
    
    func communicationManager(manager: GMBLCommunicationManager!, presentLocalNotificationsForCommunications communications: [AnyObject]!, forVisit visit: GMBLVisit!) -> [AnyObject]! {
        if communications is [GMBLCommunication] {
            for comm in communications {
                println("title: \(comm.title), description: \(comm.description))")
            }
        }
        return communications
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


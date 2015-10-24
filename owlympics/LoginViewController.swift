//
//  LoginViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 9/18/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GPPSignInDelegate {
    
    var signIn: GPPSignIn? = GPPSignIn.sharedInstance()
    @IBAction func PressSignIn(sender: AnyObject) {
        setUpSignUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func setUpSignUp(){
        //signIn = GPPSignIn.sharedInstance()
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.shouldFetchGoogleUserEmail = true  // Uncomment to get the user's email
        signIn?.shouldFetchGoogleUserID = true
        signIn?.clientID = "323701751721-nq3900gl90p3js5nig9i5k1a65cbv371.apps.googleusercontent.com"
        signIn?.scopes = [kGTLAuthScopePlusLogin]
        signIn?.delegate = self
        signIn?.authenticate()
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        //signIn = GPPSignIn.sharedInstance()
        let acccount = signIn?.userEmail
        //storeDataToLocal(acccount!, "account")
        //storeDataToLocal(signIn!, "signIn")
        self.performSegueWithIdentifier("FinishAuth", sender: self)
        
    }
    
    func didDisconnectWithError(error: NSError!) {
        println("not signed in")
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

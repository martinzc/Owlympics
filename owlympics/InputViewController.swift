//
//  InputViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 8/29/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit
import Foundation

class InputViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var input_exercise: UITextField!
    @IBOutlet weak var input_duration: UITextField!
    @IBOutlet weak var intensityPicker: UIPickerView!
    //    Configure Picker View
    let intensity_lst = ["Light","Mild","Heavy","Very Heavy"]
    @IBOutlet var durationLabel: UILabel!
    var userInput: Bool!
    var client: MSClient?
    var table:MSTable?
    @IBAction func AddExercise(sender: AnyObject) {
        if addExercise() == true {
            registerForegroundNotificationForAny(self, message: "You have succesfully input an unverified activity.", title: "Congratulations")
        }
    }
    
    @IBAction func DoneAdding(sender: AnyObject) {
        performSegueWithIdentifier("sentAndDone", sender: self)
        registerForegroundNotificationForAny(self, message: "You have succesfully input an unverified activity.", title: "Congratulations")
    }
    func addExercise() -> Bool {
        var fields_filled = false
        if(input_exercise.text!.characters.count > 0 && input_duration.text!.characters.count > 0){
            print("in")
            let httpSender = requestSender()
            let timeString = NSDate().description //need get time
            let sportString = input_exercise.text //need to get from the textfiled
            let durationString = input_duration.text
            let intensityString = intensity_lst[intensityPicker.selectedRowInComponent(0)]
            print(intensityString)
            let uuidString = GPPSignIn.sharedInstance().userEmail
            let locationString = "unclear"
            let urlString = "http://ec2-52-6-56-55.compute-1.amazonaws.com/upload"
            httpSender.buildRequestFromStringsAndSend(timeString, durationString: durationString!, sportString: sportString!, locationString: locationString, intensityString: intensityString, uuidString: uuidString!, urlString: urlString)
            
            let newExercise = Exercise(tim: NSDate(), dur: durationString!, spo: sportString!, inten: intensityString, userInput: userInput)
            storeToLocal(newExercise)
            
            //azure testing
            let itemToInsert = ["time": NSDate().description, "sport": input_exercise.text, "duration": input_duration.text, "intensity": intensityString, "uuid" : uuidString]
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.table!.insert(itemToInsert) {
                (item, error) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if error != nil {
                    print("Error" + error!.description)
                }
            }
            fields_filled = true
            input_duration.text = ""
            input_exercise.text = ""
            
        }
        else {
            registerForegroundNotificationForAny(self, message: "You need to fill in all correct information", title: "Warning")
        }
        return fields_filled
    
    }

    @IBAction func sendAndDone(sender: AnyObject) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the delegates for text field
        input_duration.delegate = self
        input_exercise.delegate = self
        //set up data sync with Azure.
        client = MSClient(applicationURLString: "https://owlympics.azurewebsites.net")
        table = client!.tableWithName("Activities")
        
        // Do any additional setup after loading the view.
        intensityPicker.selectRow(intensity_lst.count/2, inComponent: 0, animated: true)
        let timeText = loadFromLocal("visitStart") as? String
        if(timeText != "No entry time available"){
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            let date = formatter.dateFromString(timeText!)!
            _ = Int(NSDate().timeIntervalSinceDate(date))
            let calendarUnit: NSCalendarUnit = [.Hour, .Minute, .Second]
            let userCalendar = NSCalendar.currentCalendar()
            let currentdate = NSDate()
            let diffInMin = userCalendar.components(calendarUnit, fromDate: date, toDate: currentdate, options: [])
        
            let hour = String(diffInMin.hour)
            let minute = String(diffInMin.minute)
            let second = String(diffInMin.second)
            let duration =  hour + " hour " + minute + " minute " + second + " second."
            durationLabel.text = duration
        }
        durationLabel.text = "No entry time available"
    }
    
    // When clicking on the field, use this method.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField == input_duration {
            // Create a button bar for the number pad
            let keyboardDoneButtonView = UIToolbar()
            keyboardDoneButtonView.sizeToFit()
            
            // Setup the buttons to be put in the system.
            let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("endEditingNow") )
            let toolbarButtons = [item]
            
            //Put the buttons into the ToolBar and display the tool bar
            keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
            textField.inputAccessoryView = keyboardDoneButtonView
            
        }
        return true
    }
    
    // This triggers the textFieldDidEndEditing method that has the textField within it.
    //  This then triggers the resign() method to remove the keyboard.
    //  We use this in the "done" button action.
    func endEditingNow(){
        self.view.endEditing(true)
    }
    
    // textfield func for the return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        input_duration.resignFirstResponder()
        input_exercise.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        input_duration.resignFirstResponder()
        input_exercise.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intensity_lst.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intensity_lst[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _ = intensity_lst[row]
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        addExercise()
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

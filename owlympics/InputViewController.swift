//
//  InputViewController.swift
//  owlympics
//
//  Created by Martin Zhou on 8/29/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var input_exercise: UITextField!
    @IBOutlet weak var input_duration: UITextField!
    @IBOutlet weak var intensityPicker: UIPickerView!
    //    Configure Picker View
    let intensity_lst = ["Light","Mild","Heavy","Very Heavy"]
    
    var userInput: Bool!
    
    @IBAction func AddExercise(sender: AnyObject) {
        if addExercise() == true {
            registerForegroundNotificationForAny(self, "You have succesfully inputted an unverified activity.", "Congratulations")
        }
//        performSegueWithIdentifier("sentAndDone", sender: self)
    }
    
    func addExercise() -> Bool {
        var fields_filled = false
        if(count(input_exercise.text) > 0 && count(input_duration.text) > 0){
            println("in")
            let httpSender = requestSender()
            let timeString = NSDate().description //need get time
            let sportString = input_exercise.text //need to get from the textfiled
            let durationString = input_duration.text
            let intensityString = intensity_lst[intensityPicker.selectedRowInComponent(0)]
            println(intensityString)
            let uuidString = loadStringFromLocal("account")
            let locationString = "unclear"
            let urlString = "http://ec2-52-6-56-55.compute-1.amazonaws.com/upload"
            httpSender.buildRequestFromStringsAndSend(timeString, durationString: durationString, sportString: sportString, locationString: locationString, intensityString: intensityString, uuidString: uuidString!, urlString: urlString)
            
            var newExercise = Exercise(tim: NSDate(), dur: durationString, spo: sportString, inten: intensityString, userInput: userInput)
            storeToLocal(newExercise)
            fields_filled = true
            input_duration.text = ""
            input_exercise.text = ""
        }
        else {
            registerForegroundNotificationForAny(self, "You need to fill in all correct information", "Warning")
        }
        return fields_filled
    
    }

    @IBAction func sendAndDone(sender: AnyObject) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        intensityPicker.selectRow(intensity_lst.count/2, inComponent: 0, animated: true)
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
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return intensity_lst[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let intensity = intensity_lst[row]
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

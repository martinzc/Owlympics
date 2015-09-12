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
    
    @IBAction func AddExercise(sender: AnyObject) {
        if(count(input_exercise.text) > 0 && count(input_duration.text) > 0){
            
            let httpSender = requestSender()
            let timeString = NSDate().description //need get time
            let sportString = input_exercise.text //need to get from the textfiled
            let durationString = input_duration.text
            let intensityString = "Mild"
            let uuidString = loadFromLocal("account")
            let locationString = "unclear"
            let urlString = "http://ec2-52-6-56-55.compute-1.amazonaws.com/upload"
            
            httpSender.buildRequestFromStringsAndSend(timeString, durationString: durationString, sportString: sportString, locationString: locationString, intensityString: intensityString, uuidString: uuidString!, urlString: urlString)
            
            var newExercise = Exercise(tim: NSDate(), dur: durationString, spo: sportString, inten: intensityString)
            storeToLocal(newExercise)
        }
        input_duration.text = ""
        input_exercise.text = ""
        
    }
    
    @IBAction func doneButton(sender: AnyObject) {

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
    
//    Configure Picker View
    let intensity_lst = ["Light","Mild","Heavy","Very Heavy"]
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

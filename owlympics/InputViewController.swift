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
    
    @IBAction func doneButton(sender: AnyObject) {
        let duration = input_duration.text
        let sport = input_exercise.text
        let intensity = "Mild"
        var newExercise = Exercise(tim: NSDate(), dur: duration, spo: sport, inten: intensity)
        storeToLocal(newExercise)
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

//
//  CharactersField.swift
//  owlympics
//
//  Created by Ziyun Wang on 9/11/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//


import Foundation
import UIKit

class CharacterField: NSObject, UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.enabled = false
        return true
    }
}

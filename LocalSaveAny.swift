//
//  LocalSaveAny.swift
//  owlympics
//
//  Created by Ziyun Wang on 9/11/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation


func storeDataToLocal(string: String, key: String){

    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setValue(string, forKey: key)

}

func loadFromLocal(key: String?) -> String?{
    let defaults = NSUserDefaults.standardUserDefaults()
    let data = defaults.valueForKey(key!) as? String
    return data
}

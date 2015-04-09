//
//  Settings.swift
//  EindopdrachtIOS
//
//  Created by User on 09/04/15.
//  Copyright (c) 2015 Jarno. All rights reserved.
//

import UIKit

class Settings: NSObject
{
    func getCheckSettings() -> String
    {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var checked = defaults.stringForKey("checkbox")
        
        if(checked == nil)
        {
            return "false"
        }
        
        return checked!
        
    }
    
    func getPickerSettings() -> String
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        var category = defaults.stringForKey("picker")
        
        if(category == nil)
        {
            return "0"
        }
        
        return category!
    }
    
    
    func saveSettings(value:Int, checked:Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(checked, forKey: "checkbox")
        defaults.setObject(value, forKey: "picker")
    }
    
    
    
   
}

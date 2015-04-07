//
//  ASync.swift
//  EindopdrachtIOS
//
//  Created by User on 07/04/15.
//  Copyright (c) 2015 Jarno. All rights reserved.
//

import UIKit

class ASync: NSObject {
    
    
    func getJSON(apiurl:String) -> String {
        // Haal het singleton session object op
        let session = NSURLSession.sharedSession()
        var json:String = ""
        // Creëer een URL object op basis van een string
        let url = NSURL(string: apiurl)
        
            let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    json = NSString(data: theData, encoding: NSUTF8StringEncoding) as String
                   
                })
            }
        })
        
        // We moeten de taak nog wel starten!
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task.resume()
        return json
    }
    
    func getJSONURL(spinner:String, check:BooleanType) -> String {
        var url = "https://api.eet.nu/venues?"
        
        if spinner != ""
        {
            url +=  "tags=" + spinner + "&"
        }
        if check {
            url += "sort_by=rating"
        }
        return url;
    }
}

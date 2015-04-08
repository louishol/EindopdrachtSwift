//
//  DetailsController.swift
//  EindopdrachtIOS
//
//  Created by Louis Hol on 08/04/15.
//  Copyright (c) 2015 Jarno. All rights reserved.
//

import UIKit

class DetailsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var id:Int!
    var number:String = ""
    var website:String = ""
    let textCellIdentifier = "TextCell"
    @IBOutlet weak var tableView: UITableView!
    var info:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getJSON() -> String {
        // Haal het singleton session object op
        let session = NSURLSession.sharedSession()
        var json:String = ""
        // Creëer een URL object op basis van een string
        
        var url = NSURL(string: "https://api.eet.nu/venues/"+String(id!))
        
        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    json = NSString(data: theData, encoding: NSUTF8StringEncoding) as String
                    self.displayDetails(json);
                })
            }
        })
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task.resume()
        return json
    }
    
    func displayDetails(json:String)
    {

        let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
        var err: NSError
        var restaurant: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
       
        if !(restaurant["name"] is NSNull)
        {
            info.append("Naam : " + (restaurant["name"] as NSString))
        } else {
            info.append("Naam : Geen");
        }
        if !(restaurant["category"] is NSNull)
        {
            info.append("Categorie : " + (restaurant["category"] as NSString))
        } else {
            info.append("Categorie : Geen");
        }
        if !(restaurant["telephone"] is NSNull)
        {
            info.append("Telefoon : " + (restaurant["telephone"] as NSString))
            number = restaurant["telephone"] as String
        } else {
            info.append("Telefoon : Geen");
            number = "Geen"
        }
        if !(restaurant["mobile"] is NSNull)
        {
            info.append("Mobiel : " + (restaurant["mobile"] as NSString))
        } else {
            info.append("Mobiel : Geen");
        }
        if !(restaurant["website_url"] is NSNull)
        {
            info.append("Website : " + (restaurant["website_url"] as NSString))
            website = restaurant["website_url"] as String

        } else {
            info.append("Website : Geen");
            website = "Geen"
        }
        var location: NSDictionary = restaurant["address"] as NSDictionary
        
        if !(location["street"] is NSNull)
        {
            info.append("Straat : " + (location["street"] as NSString))
        } else {
            info.append("Straat : Geen");
        }
        if !(location["zipcode"] is NSNull)
        {
            info.append("Postcode : " + (location["zipcode"] as NSString))
        } else {
            info.append("Postcode : Geen");
        }
        if !(location["city"] is NSNull)
        {
            info.append("Woonplaats : " + (location["city"] as NSString))
        } else {
            info.append("Woonplaats : Geen");
        }
        if !(location["region"] is NSNull)
        {
            info.append("Provincie : " + (location["region"] as NSString))
        } else {
            info.append("Provincie : Geen");
        }
        if !(location["country"] is NSNull)
        {
            info.append("Land : " + (location["country"] as NSString))
        } else {
            info.append("Land : Geen");
        }

        
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("count is " + String(info.count))
        return info.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let row = indexPath.row
        cell.textLabel?.text =  info[row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    @IBAction func startURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:website)!)
    }
    
}

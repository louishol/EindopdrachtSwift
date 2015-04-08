//
//  TableResultsController.swift
//  EindopdrachtIOS
//
//  Created by Louis Hol on 08/04/15.
//  Copyright (c) 2015 Jarno. All rights reserved.
//

import UIKit

class TableResultsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
    var JSON:String!
    var restaurants = Dictionary<String,Int>()
    let textCellIdentifier = "TextCell"
    var textselected = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON(JSON)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                    self.fillTableView(json)
                })
            }
        })
        
        // We moeten de taak nog wel starten!
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task.resume()
        return json
    }

    func fillTableView(jsonstring:String)
    {
        
        let data = jsonstring.dataUsingEncoding(NSUTF8StringEncoding)!
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        var results: NSArray = jsonResult["results"] as NSArray
        
        for restau in results
        {
            var name = restau["name"] as NSString
            var id = restau["id"] as NSInteger
            restaurants[name] = id;
        }
        self.tableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        var key : String = Array(restaurants.keys)[row]
        cell.textLabel?.text = key
        return cell
    }
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        textselected = Array(restaurants.keys)[row] as NSString
    
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "details") {
            
            let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
            let index = selectedIndex?.item
        
            var key = Array(restaurants.keys)[index!] as NSString
            
            var svc = segue!.destinationViewController as DetailsController;
            svc.id =  restaurants[key]
            
    
        }
    }
    
    
    
    
    
    
    
}

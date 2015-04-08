//
//  RestaurantsController.swift
//  EindopdrachtIOS
//
//  Created by User on 07/04/15.
//  Copyright (c) 2015 Jarno. All rights reserved.
//

import UIKit

class RestaurantsController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {


    
    @IBOutlet weak var myPicker: UIPickerView!
    
   

    
    @IBOutlet weak var switchonoff: UISwitch!
    
    


    
    
    var text = "Alle categorien"
    let pickerData = ["Alle categorien","African","Asian","Australian","Balkan","BBQ","Bistro","Chinese","Dutch","East-european", "Eatery","Egyptian","English","Fish","Fondue","Food-vendor","French","Fusion","Greek","Grill", "Ice-cream-parlor", "Indian","Indonesian","International","Israeli","Italian","Japanese","Kebab","Lunchroom","Maroccan","Mexican", "Pancake", "Pizza","Portuguese","Regional","Russian","Sandwiches","Scandinavian","Snackbar","Surinamese","Sushi","Tapas", "Wok"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self


       let defaults = NSUserDefaults.standardUserDefaults()
        var checked = defaults.boolForKey("checkbox")
        if let name = defaults.stringForKey("checkbox")
        {
            switchonoff.setOn(checked, animated: false)
        }
        var category = defaults.integerForKey("picker")
        if let name = defaults.stringForKey("picker")
        {
            myPicker.selectRow(category, inComponent: 0, animated: false)
        }
        
    }
    
    //MARK: - Delegates and datasources
    //MARK: Data Sources
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = pickerData[row]
    }
    
    func getJSONURL() -> String {
        var check:BooleanType = switchonoff.on;
        var url = "https://api.eet.nu/venues?"
        
        if text != "Alle categorien"
        {
            url +=  "tags=" + text + "&"
        }
        if check {
            url += "sort_by=rating"
        }
        return url;
    }

//   @IBAction func search(sender: AnyObject) {
//
//    var switchenabled:BooleanType = switchonoff.on;
//        var JSONurl = getJSONURL(text, check: switchenabled)
//        println(" URL IS " + JSONurl);
//    
//        let tableview:TableViewController = TableViewController()
//        self.presentViewController(tableview, animated: true, completion: nil)
//    
//
//    }
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "tableview") {
            var svc = segue!.destinationViewController as TableResultsController;
            svc.JSON = getJSONURL()
            
        }
    }
    
    
    
    
    
}
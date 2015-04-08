//
//  SettingsController.swift
//  EindopdrachtIOS
//
//  Created by Jarno van Wijgerden on 08/04/15.
//  Copyright (c) 2015 Jarno. All rights reserved.
//

import UIKit

class SettingsController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate
{
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    @IBOutlet weak var pkrCategory: UIPickerView!
    @IBOutlet weak var ckbxWaardering: UISwitch!
    
    var pickerIndex = 0
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        pkrCategory.delegate = self
        pkrCategory.dataSource = self
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var checked = defaults.boolForKey("checkbox")
        if let name = defaults.stringForKey("checkbox")
        {
            ckbxWaardering.setOn(checked, animated: false)
        }
        var category = defaults.integerForKey("picker")
        if let name = defaults.stringForKey("picker")
        {
            pkrCategory.selectRow(category, inComponent: 0, animated: false)
        }

        // Do any additional setup after loading the view.
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerIndex = row
    }


    @IBAction func btnSave(sender: AnyObject)
    {
        var checkboxvalue = ckbxWaardering.on
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(checkboxvalue, forKey: "checkbox")
        defaults.setObject(pickerIndex, forKey: "picker")
        println(checkboxvalue)
        
    }
    
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

    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



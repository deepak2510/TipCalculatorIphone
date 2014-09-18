//
//  Settings.swift
//  TipCalculator
//
//  Created by Bhagchandani, Deepak on 9/17/14.
//
//

import UIKit

class Settings: UIViewController {
    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    var tipPercent : Float? = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var defaults = NSUserDefaults.standardUserDefaults()
        if let x = defaults.objectForKey("tipPercent") as? Float {
            
            var retrievedTip = x
            self.tipPercent = retrievedTip;
            self.tipPercentLabel.text = "\(self.tipPercent!)%";
            self.tipSlider.setValue(self.tipPercent!, animated: true)
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func settingsTapped(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.tipPercent, forKey: "tipPercent")
        
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        var tipPercent = lroundf(sender.value)._bridgeToObjectiveC().floatValue
        self.tipPercent = tipPercent
        self.tipPercentLabel.text = "\(tipPercent)%";
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

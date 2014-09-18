//
//  ViewController.swift
//  TipCalculator
//
//  Created by Bhagchandani, Deepak on 9/17/14.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var billAmount : Double? = 0.0
    var tipPercent : Double? = 15.0
    var tipAmount : Double? = 0.0
    var total : Double? = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.retrieveSetting()
        self.tipPercentLabel.text = "Calculated Tip @\(self.tipSlider.value)%"
        
    }
    
    @IBAction func screenTapped(sender: AnyObject) {
        view.endEditing(true);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.retrieveSetting()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        var defaults = NSUserDefaults.standardUserDefaults()
        self.billAmount = self.billField.text.stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "$"))._bridgeToObjectiveC().doubleValue
        defaults.setObject(self.billAmount, forKey: "billAmount")
        defaults.synchronize()
        
    }
    func retrieveSetting(){
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if let x = defaults.objectForKey("tipPercent") as? Float {
            var retrievedTip = x;
            self.tipSlider.setValue(retrievedTip, animated: true)
            self.tipPercent = retrievedTip._bridgeToObjectiveC().doubleValue;
        }
        
        if let y = defaults.objectForKey("billAmount") as? Double {
            var retrievedBillAmount = y;
            self.billField.text = "\(retrievedBillAmount)"
            self.billAmount = retrievedBillAmount._bridgeToObjectiveC().doubleValue;
        }
        
        self.recalculate()
        
        
    }
    
    
    @IBAction func recalculate(){
        
        self.billAmount = self.billField.text.stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "$"))._bridgeToObjectiveC().doubleValue
        
        self.tipAmount = self.billAmount! * (self.tipPercent!/100);
        
        self.total = self.billAmount! + self.tipAmount!;
        
        self.updateView();
        
    }
    
    
    
    func updateView(){
        if let tip = self.tipAmount {
            self.tipLabel.text = "$\(self.tipAmount!)"
        }
        if let total = self.total {
            self.totalLabel.text = "$\(total)"
            
        }
        if let tipPercent = self.tipPercent {
            self.tipPercentLabel.text = "Calculated Tip @\(tipPercent)%"
        }
        
    }
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var tipPercent = lroundf(sender.value)._bridgeToObjectiveC().doubleValue
        self.tipPercent = tipPercent;
        self.tipPercentLabel.text = "Calculated Tip @\(self.tipPercent!)%"
        self.recalculate()
    }
    
    
    
}


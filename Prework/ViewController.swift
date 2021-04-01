//
//  ViewController.swift
//  Prework
//
//  Created by Isaac Perez on 3/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // user doesn't have to click in billAmountTextField
        // key board is automatically brought up so they can enter amount
        self.billAmountTextField.becomeFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //call calculateTip to update labels when switching back to calculator
        calculateTip(self)
        //make sure the tip control lables mathc the custom labels
        tipControl.setTitle("\(defaults.integer(forKey: tip1))%", forSegmentAt:0)
        tipControl.setTitle("\(defaults.integer(forKey: tip2))%", forSegmentAt:1)
        tipControl.setTitle("\(defaults.integer(forKey: tip3))%", forSegmentAt:2)
        self.billAmountTextField.becomeFirstResponder()
    }
    
   
    @IBAction func calculateTip(_ sender: Any) {
        //get the bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
       
        //calculate the tip and total
        //divid by 100 to get the percentage
        let tipPercentages = [ Double(defaults.float(forKey: tip1))/100.0,
                               Double (defaults.float(forKey: tip2))/100.0,
                               Double (defaults.float(forKey: tip3))/100.0]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        //update tip and total labels
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        // round the value from the slider
        // so that tipPerPerson doesnt change before it get to the next whole number on the slider
        let personCount = round(splitSlider.value)
        let tipPerPerson: Double = tip / Double(personCount)
        
        tipPerPersonLabel.text = String(format: "$%.2f Per Person", tipPerPerson)
        
    
    }
    
    @IBAction func tipSplitter(_ sender: Any) {
        
        // source: https://www.journaldev.com/22833/ios-uislider begin
        // make the slider stop at intervals of 1
        let uiSlider = sender as! UISlider
        let step:Float = 1
        let roundedStepValue = round(uiSlider.value / step) * step
        uiSlider.value = roundedStepValue
        // source end
        if(Int(splitSlider.value) == 1){
            splitLabel.text = "Split 1 Way"
        }else{
            splitLabel.text = String(format: "Split %i Ways", Int(splitSlider.value))
        }
        
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
}


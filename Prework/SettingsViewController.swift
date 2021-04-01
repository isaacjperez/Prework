//
//  SettingsViewController.swift
//  Prework
//
//  Created by Isaac Perez on 3/30/21.
//

import UIKit

//keys for defaults.set
//placed here to make accessible to viewController
let tip1 = "tip1"
let tip2 = "tip2"
let tip3 = "tip3"

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip1Field: UITextField!
    @IBOutlet weak var tip2Field: UITextField!
    @IBOutlet weak var tip3Field: UITextField!
    
    
    
    //get the values from the custom tip fields as integers
    lazy var tip1Value = Int(tip1Field.text!) ?? 0
    lazy var tip2Value = Int(tip2Field.text!) ?? 0
    lazy var tip3Value = Int(tip3Field.text!) ?? 0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //make sure custom tip fields hold thier value when
        //switching back to the settings page
        let updatedTip1 : Int = Int(defaults.float(forKey: tip1))
        let updatedTip2 : Int = Int(defaults.float(forKey: tip2))
        let updatedTip3 : Int = Int(defaults.float(forKey: tip3))
        
        tip1Field.text = "\(updatedTip1)"
        tip2Field.text = "\(updatedTip2)"
        tip3Field.text = "\(updatedTip3)"
        
        self.tip1Field.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //as we transition back to the main screen
        //save what is in the tip textfields
        defaults.set(tip1Value, forKey: tip1)
        defaults.set(tip2Value, forKey: tip2)
        defaults.set(tip3Value, forKey: tip3)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}

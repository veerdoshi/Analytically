//
//  HeartViewController.swift
//  Analytically
//
//  Created by Veer Doshi on 4/16/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit
import Alamofire

var formFilled = false

class HeartViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    @IBOutlet weak var text6: UITextField!
    @IBOutlet weak var text7: UITextField!
    @IBOutlet weak var text8: UITextField!
    @IBOutlet weak var text9: UITextField!
    @IBOutlet weak var text10: UITextField!
    @IBOutlet weak var text11: UITextField!
    
    let age = 35
    let sex = 1
    let name = "Jerry"
    let url = "https://analytically.herokuapp.com/heartdata/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.text1.delegate = self
        self.text2.delegate = self
        self.text3.delegate = self
        self.text4.delegate = self
        self.text5.delegate = self
        self.text6.delegate = self
        self.text7.delegate = self
        self.text8.delegate = self
        self.text9.delegate = self
        self.text10.delegate = self
        self.text11.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func heartButton(_ sender: UIButton) {
        
        let cp = Int(text1.text!) ?? 0
        let trestbps = Float(text2.text!) ?? 0.0
        let chol = Float(text3.text!) ?? 0.0
        let fbs = Int(text4.text!) ?? 0
        let restecg = Int(text5.text!) ?? 0
        let thalach = Float(text6.text!) ?? 0.0
        let exang = Int(text7.text!) ?? 0
        let oldpeak = Float(text8.text!) ?? 0.0
        let slope = Int(text9.text!) ?? 0
        let ca = Int(text10.text!) ?? 0
        let thal = Int(text11.text!) ?? 0
        
        
        let parameters: Parameters = ["age": age, "sex": sex, "cp": cp, "trestbps": trestbps, "chol": chol, "fbs": fbs, "restecg": restecg, "thalach": thalach, "exang": exang, "oldpeak": oldpeak, "slope": slope, "ca": ca, "thal": thal]
        
        let appendedURL = url+name
        AF.request(appendedURL, method: .put, parameters: parameters).responseString { response in
        }
        
        formFilled = true
        
        let alert = UIAlertController(title: "Success", message: "The inputted heart data has been sent to a server for calculation. Please swipe down to exit this form and press the refresh button to view whether the patient is at risk of heart failure.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    

}

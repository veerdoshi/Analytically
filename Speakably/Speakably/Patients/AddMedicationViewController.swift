//
//  AddMedicationViewController.swift
//  Analytically
//
//  Created by Veer Doshi on 4/17/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit

class AddMedicationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var medicationText: UITextField!
    @IBOutlet weak var quantityText: UITextField!
    @IBOutlet weak var unitText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.medicationText.delegate = self
        self.quantityText.delegate = self
        self.unitText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    @IBAction func yesPressed(_ sender: UIButton) {
        if (medicationText.text != "") && (quantityText.text != "") && (unitText.text != "") {
            let quantity = quantityText.text ?? ""
            let unit = unitText.text ?? ""
            let medication = medicationText.text ?? ""
            let confirmMessage = "Do you confirm the order of " + quantity + " " + unit + " of " + medication + "?"
            
            let alert = UIAlertController(title: "Confirm Order", message: confirmMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                let confirmalert = UIAlertController(title: "Order Confirmed", message: "Prescription order has been confirmed. Swipe down to exit the prescription order page.", preferredStyle: UIAlertController.Style.alert)
                confirmalert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(confirmalert, animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Form Not Completed", message: "Please complete all elements of the prescription form.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func noPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Prescription Order Cancelled", message: "Please swipe down to exit the prescription order page.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

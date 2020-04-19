//
//  SecondLoginPage.swift
//  Analytically
//
//  Created by Doshi, Veer on 1/2/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit

var firstname: String = ""
var lastname: String = ""

class SecondLoginPage: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    @IBOutlet weak var text6: UITextField!
    @IBOutlet weak var text7: UITextField!
    @IBOutlet weak var text8: UITextField!
    
    
    @IBOutlet weak var PageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PageView.layer.cornerRadius = 15
        PageView.layer.shadowColor = UIColor.black.cgColor
        PageView.layer.shadowOpacity = 1
        PageView.layer.shadowOffset = .zero
        PageView.layer.shadowRadius = 10

        self.text1.delegate = self
        self.text2.delegate = self
        self.text3.delegate = self
        self.text4.delegate = self
        self.text5.delegate = self
        self.text6.delegate = self
        self.text7.delegate = self
        self.text8.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func continueButton(_ sender: UIButton) {
        firstname = text2.text ?? ""
        lastname = text3.text ?? ""
        
        performSegue(withIdentifier: "secondToThird", sender: self)
    }
    
}

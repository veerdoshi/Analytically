//
//  ThirdLoginPage.swift
//  Analytically
//
//  Created by Doshi, Veer on 1/2/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit
import LocalAuthentication
import iOSDropDown

class ThirdLoginPage: UIViewController {

    @IBOutlet weak var DepartmentSelector: DropDown!
    @IBOutlet weak var PageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PageView.layer.cornerRadius = 15
        PageView.layer.shadowColor = UIColor.black.cgColor
        PageView.layer.shadowOpacity = 1
        PageView.layer.shadowOffset = .zero
        PageView.layer.shadowRadius = 10
        DepartmentSelector.isSearchEnable = true
        DepartmentSelector.optionArray = departments
        DepartmentSelector.rowBackgroundColor = .darkGray
        DepartmentSelector.selectedRowColor = .gray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let myContext = LAContext()
            let myLocalizedReasonString = "Biometric Authentication For User Login"
            
            var authError: NSError?
            if #available(iOS 8.0, macOS 10.12.1, *) {
                if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                    myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                        
                        DispatchQueue.main.async {
                            if success {
                                // User authenticated successfully, take appropriate action
                                print("Authenticated")
                                self.performSegue(withIdentifier: "loginToHome", sender: self)
                            } else {
                                // User did not authenticate successfully, look at error and take appropriate action
                                print("Not authenticated")
                            }
                        }
                    }
                } else {
                    // Could not evaluate policy; look at authError and present an appropriate message to user
                    print("Policy not evaluated")
                }
            } else {
                // Fallback on earlier versions
                print("Doesn't work")
            }
            
            
        }

}

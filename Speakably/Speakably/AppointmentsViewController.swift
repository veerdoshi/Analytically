//
//  AppointmentsViewController.swift
//  Speakably
//
//  Created by Doshi, Hemal on 1/3/20.
//  Copyright © 2020 Doshi, Hemal. All rights reserved.
//

import UIKit


class AppointmentsViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.alpha = 0
        self.nameLabel.alpha = 0
        //nameLabel.text = "\(firstname) \(lastname)"
        nameLabel.text = "Veer Doshi"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 2.5) {
            self.welcomeLabel.alpha = 1.0
            self.nameLabel.alpha = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            UIView.animate(withDuration: 2.5) {
                self.welcomeLabel.alpha = 0
                self.nameLabel.alpha = 0
            }
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MedsViewController.swift
//  Speakably
//
//  Created by Veer Doshi on 1/10/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit

class MedsViewController: UIViewController {

    @IBOutlet weak var PageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PageView.layer.cornerRadius = 15
        PageView.layer.shadowColor = UIColor.black.cgColor
        PageView.layer.shadowOpacity = 1
        PageView.layer.shadowOffset = .zero
        PageView.layer.shadowRadius = 10

        // Do any additional setup after loading the view.
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

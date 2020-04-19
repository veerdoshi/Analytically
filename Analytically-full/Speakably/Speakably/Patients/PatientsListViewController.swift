//
//  PatientsListViewController.swift
//  Analytically
//
//  Created by Veer Doshi on 1/4/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit

class PatientsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data : [String] = patientslist
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       cell.textLabel?.text = data[indexPath.row]
       return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if (indexPath.row == 7){
            performSegue(withIdentifier: "patientsSegue", sender: self)
        }
    }
    

}

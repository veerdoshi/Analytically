//
//  PatientsInterfaceViewController.swift
//  Analytically
//
//  Created by Veer Doshi on 1/4/20.
//  Copyright © 2020 Doshi, Veer. All rights reserved.
//

import UIKit
import NavigationDropdownMenu
import Alamofire
import SwiftyJSON

class PatientsInterfaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data : [String] = noteslist
    
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var prescriptionsView: UIView!
    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heartDiseaseRisk: UITextField!
    
    let url = "https://analytically.herokuapp.com/riskheartdisease/Jerry"
    
    var menuView: NavigationDropdownMenu!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.isHidden = false
        notesView.isHidden = true
        statsView.isHidden = true
        prescriptionsView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = "https://analytically.herokuapp.com/riskheartdisease/Jerry"
        
        let items = [" Home", " Notes", " Prescribe", " Stats"]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        menuView = NavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: Title.index(0), items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor(red: 33/255.0, green:147/255.0, blue:176/255.0, alpha: 1.0)
        menuView.cellSelectionColor = UIColor(red: 33/255.0, green:181/255.0, blue:176/255.0, alpha: 1.0)
        
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Helvetica Neue", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.cellSeparatorColor = UIColor(red: 33/255.0, green:147/255.0, blue:176/255.0, alpha: 1.0)
        menuView.showRightLine = false
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("Did select item at index: \(indexPath)")
            print(items[indexPath])
            
            if indexPath == 0 {
                self.homeView.isHidden = false
                self.notesView.isHidden = true
                self.statsView.isHidden = true
                self.prescriptionsView.isHidden = true
            } else if indexPath == 1{
                self.homeView.isHidden = true
                self.notesView.isHidden = false
                self.statsView.isHidden = true
                self.prescriptionsView.isHidden = true
            } else if indexPath == 2{
                self.homeView.isHidden = true
                self.notesView.isHidden = true
                self.statsView.isHidden = true
                self.prescriptionsView.isHidden = false
            } else if indexPath == 3{
                self.homeView.isHidden = true
                self.notesView.isHidden = true
                self.statsView.isHidden = false
                self.prescriptionsView.isHidden = true

                AF.request(url, method: .get).responseJSON { response in
                    let result : JSON = JSON(response.value!)
                    
                    if (result["data"]==false) {
                        self.heartDiseaseRisk.text = "-"
                        print("No heart risk data")
                    } else if (result["data"]==0) {
                        self.heartDiseaseRisk.text = "Low"
                    } else if (result["data"]==1) {
                        self.heartDiseaseRisk.text = "High"
                    } else {
                        self.heartDiseaseRisk.text = "-"
                        print("Internal Server Error")
                    }
                }
            }
        }
        
        self.navigationItem.titleView = menuView

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       cell.textLabel?.text = data[indexPath.row]
       return cell
    }
    
    @IBAction func refreshStats(_ sender: UIButton) {
        AF.request(url, method: .get).responseJSON { response in
            let result : JSON = JSON(response.value!)
            
            if (result["data"]==false) {
                self.heartDiseaseRisk.text = "-"
                print("No heart risk data")
            } else if (result["data"]==0) {
                self.heartDiseaseRisk.text = "Low"
            } else if (result["data"]==1) {
                self.heartDiseaseRisk.text = "High"
            } else {
                self.heartDiseaseRisk.text = "-"
                print("Internal Server Error")
            }
        }
    }
    
    @IBAction func dataEnter(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Type of Data", message: "Please select the type of patient data that you are entering.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cardiovascular Data", style: .default, handler: { action in
            self.performSegue(withIdentifier: "statsToHeart", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Respiratory Data", style: .default, handler: { action in
            let respalert = UIAlertController(title: "Under Development", message: "The respiratory data form is currently under development.", preferredStyle: UIAlertController.Style.alert)
            respalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(respalert, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Allergy Data", style: .default, handler: { action in
            let allergyalert = UIAlertController(title: "Under Development", message: "The allergy data form is currently under development.", preferredStyle: UIAlertController.Style.alert)
            allergyalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(allergyalert, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

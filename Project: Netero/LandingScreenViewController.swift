//
//  LandingScreenViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-05-31.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit
import Alamofire

class LandingScreenViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var regionPickerView: UIPickerView!
    
    let communicator = Communicator()
    let errorHandler = ErrorHandler()
    let regions = ["North America", "Korea", "Japan", "Europe West", "Europe Nordic & East"]
    
    var responseObject: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionPickerView.dataSource = self
        regionPickerView.delegate = self
        searchButton.defaultStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        let searchText = searchField.text
        //ToDo: Add activity spinner later
        searchButton.disable()
        if searchText!.range(of: "^[0-9\\p{L} _\\.]+$", options: .regularExpression) != nil {
            communicator.getSummoner(region: "NA1", summonerName: searchText!) { responseObject, error in
                if responseObject != nil{
                    self.searchButton.enable()
                    self.responseObject = responseObject
                    self.performSegue(withIdentifier: "showSummonerProfileSegue", sender: self)
                } else {
                    self.errorHandler.showErrorAlert(alertTitle: "Summoner not found", message: "Please enter a different Summoner Name", vc: self)
                    self.searchButton.enable()
                }
                
                return
            }
        } else {
            errorHandler.showErrorAlert(alertTitle: "Invalid Summoner Name", message: "Please enter a correct Summoner Name", vc: self)
            searchButton.enable()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummonerProfileSegue" {
            let summonerProfileVC = segue.destination as! SummonerProfileViewController
            summonerProfileVC.summonerObject = responseObject
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row]
    }
}

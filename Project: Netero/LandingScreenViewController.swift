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
    
    var responseObject: [String:Any]?
    var selectedRegion: String! {
        didSet {
            regionPlatform = getRegionsAsscoiatedPlatform(selectedRegion!).lowercased()
        }
    }
    
    var regionPlatform: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionPickerView.dataSource = self
        regionPickerView.delegate = self
        selectedRegion = RiotApiHelpers.REGIONS.first
        searchButton.defaultStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        let searchText = searchField.text
        searchButton.disable()
        if searchText!.range(of: "^[0-9\\p{L} _\\.]+$", options: .regularExpression) != nil {
            communicator.getSummoner(region: regionPlatform, summonerName: searchText!) { responseObject, error in
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
            summonerProfileVC.regionPlatform = regionPlatform
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RiotApiHelpers.REGIONS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RiotApiHelpers.REGIONS[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRegion = RiotApiHelpers.REGIONS[row]
    }
}

extension LandingScreenViewController {
    func getRegionsAsscoiatedPlatform(_ region: String) -> String {
        switch region {
        case "North America":
            return "NA1"
        case "Korea":
            return "KR"
        case "Japan":
            return "JP1"
        case "Europe West":
            return "EUW1"
        case "Europe Nordic & East":
            return "EUN1"
        case "Oceania":
            return "OC1"
        case "Brazil":
            return "BR1"
        case "LAS":
            return "LA2"
        case "LAN":
            return "LA1"
        case "Russia":
            return "RU"
        case "Turkey":
            return "TR1"
        case "PBE":
            return "PBE1"
        default:
            return "NA1"
        }
    }
}

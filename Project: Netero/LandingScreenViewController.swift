//
//  LandingScreenViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-05-31.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit
import Alamofire

class LandingScreenViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let communicator = Communicator()
    let errorHandler = ErrorHandler()
    
    var resposneObject: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    print(responseObject!)
                    self.searchButton.enable()
                    self.resposneObject = responseObject
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
}

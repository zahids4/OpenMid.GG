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
        if searchText!.range(of: "^[0-9\\p{L} _\\.]+$", options: .regularExpression) != nil {
            communicator.getSummoner(region: "NA1", summonerName: searchText!) { responseObject, error in
                if responseObject != nil{
                    print(responseObject!)
                    self.resposneObject = responseObject
                } else {
                    print("API Error" ,error!)
                }
                
                return
            }
        } else {
            print("text error")
        }
    }
}

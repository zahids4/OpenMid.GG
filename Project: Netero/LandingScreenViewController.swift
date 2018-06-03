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
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.defaultStyle()
        communicator.getSummoner(region: "NA1", summonerName: "vocalizedpanda")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

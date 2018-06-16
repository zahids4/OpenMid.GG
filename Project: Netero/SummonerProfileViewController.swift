//
//  SummonerProfileViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-06-10.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class SummonerProfileViewController: UIViewController {
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerLevelLabel: UILabel!
    let communicator = Communicator()
    var summonerObject: [String:Any]!
    var regionPlatform: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configueView() {
        let summonerName = summonerObject.stringValueForKey("name")
        let summonerLevel = summonerObject.integerValueForKey("summonerLevel")
        let summonerId = summonerObject.id()
        summonerNameLabel.text = summonerName
        summonerLevelLabel.text = String(summonerLevel)
        
        getSummunorRankAttributes(String(summonerId))
    }
    
    private func getSummunorRankAttributes(_ summonerId: String) {
        communicator.getCallForSummunorRank(regionPlatform, summonerId) { rankObject, error in
            if rankObject != nil {
                print("Rank Object", rankObject!)
            } else {
                print("An error occured", error as Any)
            }
            
            return
        }
    }
}

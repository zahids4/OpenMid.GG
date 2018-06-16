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
    @IBOutlet weak var rankAndTierLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    let communicator = Communicator()
    var summonerObject: [String:Any]!
    var regionPlatform: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        communicator.performOnMainThread {
            self.configueView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        getSummunorRankAttributes(summonerId)
    }
    
    private func getSummunorRankAttributes(_ summonerId: Int) {
        let stringifiedSummunorId = String(summonerId)
        communicator.getCallForSummunorRank(regionPlatform, stringifiedSummunorId) { rankObjects, error in
            if rankObjects != nil {
                self.constructRankingLabels(rankObjects)
            } else {
                print("An error occured", error as Any)
            }
            
            return
        }
    }
    
    fileprivate func constructRankingLabels(_ rankObjects: [[String : Any]]?) {
        for rankObject in rankObjects! {
            if rankObject.stringValueForKey("queueType") == "RANKED_SOLO_5x5" {
                let rank = rankObject.stringValueForKey("rank")
                let tier = rankObject.stringValueForKey("tier")
                let leagueName = rankObject.stringValueForKey(("leagueName"))
                self.rankAndTierLabel.text! = tier + " " + rank
                self.leagueLabel.text! = leagueName
            }
        }
    }
}

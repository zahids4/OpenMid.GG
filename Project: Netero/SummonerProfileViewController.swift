//
//  SummonerProfileViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-06-10.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit
import SkeletonView

class SummonerProfileViewController: UIViewController {
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerLevelLabel: UILabel!
    @IBOutlet weak var summonerProfileIcon: UIImageView!
    @IBOutlet weak var rankAndTierLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var tierImageView: UIImageView!
    @IBOutlet weak var winLossLPLabel: UILabel!
    @IBOutlet weak var winRatioLabel: UILabel!
    
    let communicator = Communicator()
    let gradient = SkeletonGradient(baseColor: UIColor.clouds)
    
    var summonerObject: [String:Any]!
    var regionPlatform: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSkeletonViews()
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
    
    fileprivate func configueView() {
        constructNameAndLevelLabels(summonerObject!)
        getSummunorRankAttributes(summonerObject!)
    }
    
    fileprivate func constructNameAndLevelLabels(_ summonerObject: [String:Any]) {
        let summonerName = summonerObject.stringValueForKey("name")
        let summonerLevel = summonerObject.integerValueForKey("summonerLevel")
        summonerNameLabel.text = summonerName
        summonerLevelLabel.text = String(summonerLevel)
    }
    
    fileprivate func getSummunorRankAttributes(_ summonerObject: [String:Any]) {
        let summonerId = summonerObject.id()
        let stringifiedSummunorId = String(summonerId)
        communicator.getCallForSummunorRank(regionPlatform, stringifiedSummunorId) { rankObjects, error in
            if rankObjects != nil {
                self.constructRankingLabels(rankObjects)
                self.constructWinLossLPLabel(rankObjects)
            } else {
                print("An error occured", error as Any)
            }
            
            return
        }
    }
    
    fileprivate func constructRankingLabels(_ rankObjects: [[String : Any]]?) {
        for rankObject in rankObjects! {
            if rankObject.stringValueForKey("queueType") == ApiKeys.RANKED_SOLO {
                let rank = rankObject.stringValueForKey("rank")
                let tier = rankObject.stringValueForKey("tier")
                let leagueName = rankObject.stringValueForKey(ApiKeys.LEAGUE_NAME)
                self.rankAndTierLabel.text! = tier + " " + rank
                self.leagueLabel.text! = leagueName
            }
        }
    }
    
    fileprivate func constructWinLossLPLabel(_ rankObjects: [[String:Any]]?) {
        for rankObject in rankObjects! {
            if rankObject.stringValueForKey("queueType") == ApiKeys.RANKED_SOLO {
                let wins = rankObject.integerValueForKey("wins")
                let losses = rankObject.integerValueForKey("losses")
                let leaguePoints = rankObject.integerValueForKey("leaguePoints")
                winLossLPLabel.text! = "\(wins) W \(losses) L \(leaguePoints) LP"
                constructWinRatioLabel(wins, losses)
            }
        }
    }
    
    fileprivate func constructWinRatioLabel(_ wins: Int,_ losses: Int) {
        let winRatio = getWinRatio(wins, losses)
        winRatioLabel.text! = "You have won \(winRatio)% of your games"
    }
    
    fileprivate func showSkeletonViews() {
        tierImageView.showAnimatedGradientSkeleton(usingGradient: gradient)
        summonerProfileIcon.showAnimatedGradientSkeleton(usingGradient: gradient)
    }
}

extension SummonerProfileViewController {
    func getWinRatio(_ rhs: Int,_ lhs: Int) -> Double {
        return round((Double(rhs) / Double(rhs + lhs)) * 100)
    }
}

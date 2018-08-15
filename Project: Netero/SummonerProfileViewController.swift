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
    @IBOutlet weak var winLossLabel: UILabel!
    @IBOutlet weak var lpLabel: UILabel!
    @IBOutlet weak var winRatioLabel: UILabel!
    
    let communicator = Communicator()
    let gradient = SkeletonGradient(baseColor: UIColor.clouds)
    
    var summonerObject: [String:Any]!
    var regionPlatform: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSkeletonViews()
        configueView()
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
        setProfileIcon()
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
                if (rankObjects?.isEmpty)! {
                    self.configureUIForUnrankedSummoner()
                } else {
                    self.constructRankingAttributes(rankObjects)
                    self.constructWinLossLPLabel(rankObjects)
                }
            } else {
                print("An error occured", error as Any)
            }
            
            return
        }
    }
    
    fileprivate func configureUIForUnrankedSummoner() {
        self.tierImageView.image = UIImage(named: "provisional")
        self.rankAndTierLabel.text! = "Unranked"
        self.leagueLabel.hide()
        self.winLossLabel.hide()
        self.lpLabel.hide()
        self.winRatioLabel.hide()
    }
    
    fileprivate func constructRankingAttributes(_ rankObjects: [[String : Any]]?) {
        for rankObject in rankObjects! {
            if rankObject.stringValueForKey("queueType") == ApiKeys.RANKED_SOLO {
                let rank = rankObject.stringValueForKey("rank")
                let tier = rankObject.stringValueForKey("tier")
                self.setTierIcon(tier, rank)
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
                winLossLabel.text! = "\(wins) W \(losses) L"
                lpLabel.text! = "\(leaguePoints) LP"
                constructWinRatioLabel(wins, losses)
            }
        }
    }
    
    fileprivate func constructWinRatioLabel(_ wins: Int,_ losses: Int) {
        let winRatio = getWinRatio(wins, losses)
        winRatioLabel.text! = "You have won \(winRatio)% of your games"
    }
    
    fileprivate func setProfileIcon() {
        summonerProfileIcon.setProfileIconWith(id: summonerObject.integerValueForKey("profileIconId"))
    }
    
    fileprivate func setTierIcon(_ tier: String, _ rank: String) {
        let imageName = getImageNameFromTierAndRank(tier, rank)
        tierImageView.image = UIImage(named: imageName)
    }
    
    fileprivate func showSkeletonViews() {
        //view.showAnimatedGradientSkeleton(usingGradient: gradient)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matchesTableVCSegue" {
            let matchesTableVC = segue.destination as! MatchesTableViewController
            matchesTableVC.accountId = summonerObject.integerValueForKey("accountId")
            matchesTableVC.regionPlatform = regionPlatform
        }
    }
}

extension SummonerProfileViewController {
    func getImageNameFromTierAndRank(_ tier: String, _ rank: String) -> String {
        return tier.lowercased() + "_" + rank.lowercased()
    }
    
    func getWinRatio(_ rhs: Int,_ lhs: Int) -> Double {
        return round((Double(rhs) / Double(rhs + lhs)) * 100)
    }
}

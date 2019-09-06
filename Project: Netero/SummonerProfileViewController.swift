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
    @IBOutlet weak var summonerProfileIcon: UIImageView!
    @IBOutlet weak var rankAndTierLabel: UILabel!
    @IBOutlet weak var tierImageView: UIImageView!
    @IBOutlet weak var winLossLabel: UILabel!
    @IBOutlet weak var lpLabel: UILabel!
    @IBOutlet weak var winRatioLabel: UILabel!
    @IBOutlet weak var rankTierLabelTopConstraint: NSLayoutConstraint!
    
    let communicator = Communicator()
    
    var summonerObject: [String:Any]!
    var regionPlatform: String!
    var stringifiedSummunorId: String!
    
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
        summonerLevelLabel.text = "Level \(summonerLevel)"
    }

    
    fileprivate func getSummunorRankAttributes(_ summonerObject: [String:Any]) {
        let summonerId = summonerObject.id()
        stringifiedSummunorId = String(summonerId)
        communicator.getCallForSummunorRank(regionPlatform, stringifiedSummunorId) {
            rankObjects, error in
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
        self.rankTierLabelTopConstraint.constant = 60
        self.rankAndTierLabel.text! = "Unranked"
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
                self.rankAndTierLabel.text! = tier + " " + rank
            }
        }
    }
    
    fileprivate func constructWinLossLPLabel(_ rankObjects: [[String:Any]]?) {
        for rankObject in rankObjects! {
            if rankObject.stringValueForKey("queueType") == ApiKeys.RANKED_SOLO {
                let wins = rankObject.integerValueForKey("wins")
                let losses = rankObject.integerValueForKey("losses")
                let leaguePoints = rankObject.integerValueForKey("leaguePoints")
                winLossLabel.text! = "\(wins) Wins \(losses) Losses"
                lpLabel.text! = "\(leaguePoints) LP"
                constructWinRatioLabel(wins, losses)
            }
        }
    }
    
    fileprivate func constructWinRatioLabel(_ wins: Int,_ losses: Int) {
        let winRatio = getWinRatio(wins, losses)
        winRatioLabel.text! = "Win Ratio of \(winRatio) %"
    }
    
    fileprivate func setProfileIcon() {
        summonerProfileIcon.setProfileIconWith(id: summonerObject.integerValueForKey("profileIconId"))
        summonerProfileIcon.layer.borderWidth = 2.0
        summonerProfileIcon.layer.borderColor = UIColor.black.cgColor
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
            matchesTableVC.accountId = summonerObject.stringValueForKey("accountId")
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

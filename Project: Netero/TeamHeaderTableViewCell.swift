//
//  TeamHeaderTableViewCell.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-30.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class TeamHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var dinWinImageView: UIImageView!
    @IBOutlet weak var towersLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureRedTeamHeader(_ redTeam: [String:Any]) {
        teamName.text! = "Red Team"
        teamName.textColor = resultColor.red
        setHeaderUI(redTeam)
    }
    
    func configueBlueTeamHeader(_ blueTeam: [String:Any]) {
        teamName.text! = "Blue Team"
        teamName.textColor = resultColor.blue
        setHeaderUI(blueTeam)
    }
    
    fileprivate func setHeaderUI(_ team: [String : Any]) {
        setDidWinImage(team)
        setTowerLabel(team)
        UtilityHelper.setStatsLabel(team.stringAnyObjectForKey("stats"), statsLabel)
    }
    
    fileprivate func setTowerLabel(_ team: [String : Any]) {
        towersLabel.text = String(team.integerValueForKey("towerKills"))
    }
    
    fileprivate func setDidWinImage(_ team: [String : Any]) {
        let didTeamWin = team.stringValueForKey("win") == "Win"
        setDidWinImage(didTeamWin)
    }
    
    fileprivate func setDidWinImage(_ didWin: Bool) {
        if didWin {
            dinWinImageView.backgroundColor = resultColor.green
        } else {
            dinWinImageView.backgroundColor = resultColor.red
        }
    }
}

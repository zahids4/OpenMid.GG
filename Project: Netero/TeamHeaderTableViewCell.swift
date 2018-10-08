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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureRedTeamHeader(_ didBlueTeamWin: Bool) {
        teamName.text! = "Red Team"
        teamName.textColor = resultColor.red
        setDidWinImage(!didBlueTeamWin)
    }
    
    
    func configueBlueTeamHeader(_ didBlueTeamWin: Bool) {
        teamName.text! = "Blue Team"
        teamName.textColor = UIColor.blue
        setDidWinImage(didBlueTeamWin)
    }
    
    fileprivate func setDidWinImage(_ didBlueTeamWin: Bool) {
        if didBlueTeamWin {
            dinWinImageView.backgroundColor = resultColor.green
        } else {
            dinWinImageView.backgroundColor = resultColor.red
        }
    }
}

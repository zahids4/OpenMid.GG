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
        // Initialization code
    }
    
    func configueHeader(section: Int, didBlueTeamWin: Bool) {
        if section == 0 {
            teamName.text! = "Blue Team"
        } else {
            teamName.text! = "Red Team"
        }
        
        if didBlueTeamWin {
            dinWinImageView.backgroundColor = UIColor.green
        } else {
            dinWinImageView.backgroundColor = UIColor.red
        }
    }
}

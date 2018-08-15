//
//  MatchTableViewCell.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-08-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    @IBOutlet weak var championIconImage: UIImageView!
    @IBOutlet weak var championNameLabel: UILabel!
    @IBOutlet weak var matchStatsLabel: UILabel!
    @IBOutlet weak var kdaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUsing(_ match: [String:Any]) {
        setBackgroundColor(match)
        setStatsLabels(match)
    }
    
    fileprivate func setStatsLabels(_ match: [String : Any]) {
        let kills = match.integerValueForKey("kills")
        let assists = match.integerValueForKey("assists")
        let deaths = match.integerValueForKey("deaths")
        matchStatsLabel.text! = "\(kills) / \(assists) / \(deaths)"
        kdaLabel.text! = createKdaLabel(kills, assists, deaths)
    }
    
    fileprivate func createKdaLabel(_ kills: Int,_ assists: Int, _ deaths: Int) -> String {
        let kda = Double((kills + assists) / deaths).rounded(toPlaces: 2)
        return "\(kda) KDA"
    }
    
    fileprivate func setBackgroundColor(_ match: [String : Any]) {
        if match.boolForKey("didWin") {
            self.backgroundColor = UIColor.green
        } else {
            self.backgroundColor = UIColor.red
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

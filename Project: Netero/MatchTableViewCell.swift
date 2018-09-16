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
    @IBOutlet weak var spell1Image: UIImageView!
    @IBOutlet weak var spell2Image: UIImageView!
    
    let communicator = Communicator()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CellHelper.addSeperator(self)
    }
    
    func configureUsing(_ match: [String:Any]) {
        UtilityHelper.setChampionUIFrom(id: match.integerValueForKey("championId"), championIconImage,  championNameLabel)
        setBackgroundColor(match)
        setStatsLabels(match)
        UtilityHelper.setSpellImagesFrom(match, spell1Image, spell2Image)
    }

    fileprivate func setStatsLabels(_ match: [String : Any]) {
        let kills = match.integerValueForKey("kills")
        let assists = match.integerValueForKey("assists")
        let deaths = match.integerValueForKey("deaths")
        matchStatsLabel.text! = "\(kills) / \(deaths) / \(assists)"
        kdaLabel.text! = createKdaLabel(kills, assists, deaths)
    }
    
    fileprivate func createKdaLabel(_ kills: Int,_ assists: Int, _ deaths: Int) -> String {
        let kda =  Double(Double(kills + assists) / Double(deaths)).rounded(toPlaces: 2)
        return "\(kda) KDA"
    }
    
    fileprivate func setBackgroundColor(_ match: [String : Any]) {
        if match.boolForKey("didWin") {
            self.backgroundColor = UIColor(displayP3Red: 117/255, green: 251/255, blue: 172/255, alpha: 0.8)
        } else {
            self.backgroundColor = UIColor(displayP3Red: 176/255, green: 50/255, blue: 53/255, alpha: 0.8)
        }
    }
}

//
//  MatchTableViewCell.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-08-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var championIconImage: UIImageView!
    @IBOutlet weak var creepScoreLabel: UILabel!
    @IBOutlet weak var matchStatsLabel: UILabel!
    @IBOutlet weak var kdaLabel: UILabel!
    @IBOutlet weak var spell2Image: UIImageView!
    @IBOutlet weak var spell1Image: UIImageView!
    @IBOutlet var itemImages: [UIImageView]!
    
    let communicator = Communicator()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CellHelper.addSeperator(self)
    }
    
    
    func configureUsing(_ match: [String:Any]) {
        UtilityHelper.setItemImages(match, itemImages)
        UtilityHelper.setSpellImagesFrom(match, spell1Image, spell2Image)
        setChampionUIForCells(match)
        setLabels(match)
    }
    
    fileprivate func setChampionUIForCells(_ match: [String : Any]) {
        if match.boolForKey("isMatchCell") {
            UtilityHelper.setBackgroundColor(match.boolForKey("didWin"), view: self)
            UtilityHelper.setChampionUIFrom(id: match.integerValueForKey("championId"), championIconImage, nameLabel)
        }
        else {
            UtilityHelper.setChampionUIFrom(id: match.integerValueForKey("championId"), championIconImage)
        }
    }
    
    func setSummonerName(_ name: String) {
        nameLabel.text = name
    }
    
    fileprivate func setLabels(_ match: [String:Any]) {
        let cs = match.integerValueForKey("cs")
        UtilityHelper.setStatsLabels(match, matchStatsLabel, kdaLabel)
        creepScoreLabel.text! = "\(cs) CS"
    }
}

//
//  MatchTableViewCell.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-08-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    @IBOutlet weak var championNameLabel: UILabel!
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
        UtilityHelper.setChampionUIFrom(id: match.integerValueForKey("championId"), championIconImage, championNameLabel)
        UtilityHelper.setItemImages(match, itemImages)
        UtilityHelper.setSpellImagesFrom(match, spell1Image, spell2Image)
        UtilityHelper.setBackgroundColor(match.boolForKey("didWin"), view: self)
        setLabels(match)
    }
    
    fileprivate func setLabels(_ match: [String:Any]) {
        let cs = match.integerValueForKey("cs")
        UtilityHelper.setStatsLabels(match, matchStatsLabel, kdaLabel)
        creepScoreLabel.text! = "\(cs) CS"
    }
}

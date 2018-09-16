//
//  ParticipantTableViewCell.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var championIconImage: UIImageView!
    @IBOutlet weak var creepScoreLabel: UILabel!
    @IBOutlet weak var kdaLabel: UILabel!
    @IBOutlet weak var spell2Image: UIImageView!
    @IBOutlet weak var spell1Image: UIImageView!
    @IBOutlet var itemImages: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CellHelper.addSeperator(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSummonerName(_ name: String) {
        summonerNameLabel.text = name
    }
    
    func configureUsing(_ participant: [String:Any]) {
        UtilityHelper.setChampionUIFrom(id: participant.integerValueForKey("championId"), championIconImage)
        UtilityHelper.setItemImages(participant, itemImages)
        UtilityHelper.setSpellImagesFrom(participant, spell1Image, spell2Image)
    }
}

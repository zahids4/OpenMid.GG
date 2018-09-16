//
//  ParticipantTableViewCell.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {
    @IBOutlet weak var championIconImage: UIImageView!
    @IBOutlet weak var creepScoreLabel: UILabel!
    @IBOutlet weak var kdaLabel: UILabel!
    @IBOutlet weak var spell2Image: UIImageView!
    @IBOutlet weak var spell1Image: UIImageView!
    @IBOutlet var itemImages: [UIImageView]!
    
    let communicator = Communicator()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUsing(_ participant: [String:Any]) {
        setChampionIconFrom(id: participant.integerValueForKey("championId"))
        setItemImagesOn(participant)
        setSpellImagesFor(participant)
    }
    
    fileprivate func setItemImagesOn(_ participant: [String:Any]) {
        for (index, item) in itemImages.enumerated() {
            let itemId = participant.integerValueForKey("item\(index)")
            if itemId != 0 {
                item.setItemImageWith(id: itemId)
            } else {
                item.image = UIImage(named: "black_line")
            }
        }
    }
    
    fileprivate func setChampionIconFrom(id: Int) {
        communicator.getAllChampions() { allChampions, error in
            if allChampions != nil {
                for (key, value) in allChampions! {
                    if Int((value as! [String:Any]).stringValueForKey("key")) == id {
                        self.championIconImage.setChampionIconWith(name: key)
                    }
                }
            } else {
                print("An error occured: ", error as Any)
            }
            
        }
    }
    
    fileprivate func setSpellImagesFor(_ participant: [String : Any]) {
        let spell1Name = "spell_\(participant.integerValueForKey("spell1Id"))"
        let spell2Name = "spell_\(participant.integerValueForKey("spell2Id"))"
        spell1Image.image = UIImage(named: spell1Name)
        spell2Image.image = UIImage(named: spell2Name)
    }
}

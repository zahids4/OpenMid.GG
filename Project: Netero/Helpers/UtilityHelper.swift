//
//  UtilityHelper.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class UtilityHelper {
    static func setChampionUIFrom(id: Int, _ championIconImage: UIImageView, _ championNameLabel: UILabel? = nil) {
        let communicator = Communicator()
        DispatchQueue.global(qos: .userInteractive).async {
            communicator.getAllChampions() { allChampions, error in
                if allChampions != nil {
                    for (key, value) in allChampions! {
                        if Int((value as! [String:Any]).stringValueForKey("key")) == id {
                            if championNameLabel != nil {
                                championNameLabel?.text! = key.convertFromApiNameToChampionName().toSpaceSeperated
                            }
                            championIconImage.setChampionIconWith(name: key)
                        }
                    }
                } else {
                    print("An error occured: ", error as Any)
                }
            }
        }
    }
    
    static func setItemImages(_ itemsSource: [String:Any], _ itemImages: [UIImageView]) {
        for (index, item) in itemImages.enumerated() {
            let itemId = itemsSource.integerValueForKey("item\(index)")
            if itemId != 0 {
                item.setItemImageWith(id: itemId)
            } else {
                item.image = UIImage(named: "black_line")
            }
        }
    }
    
    
    static func setSpellImagesFrom(_ spellSource: [String : Any], _ spell1Image: UIImageView, _ spell2Image: UIImageView) {
        let spell1Name = "spell_\(spellSource.integerValueForKey("spell1Id"))"
        let spell2Name = "spell_\(spellSource.integerValueForKey("spell2Id"))"
        spell1Image.image = UIImage(named: spell1Name)
        spell2Image.image = UIImage(named: spell2Name)
    }
    
    static func setStatsLabels(_ statsSource: [String : Any], _ matchStatsLabel: UILabel, _ kdaLabel: UILabel) {
        let kills = statsSource.integerValueForKey("kills")
        let assists = statsSource.integerValueForKey("assists")
        let deaths = statsSource.integerValueForKey("deaths")
        matchStatsLabel.text! = "\(kills) / \(deaths) / \(assists)"
        kdaLabel.text! = createKdaLabel(kills, assists, deaths)
    }
    
    static func setStatsLabel(_ statsSource: [String : Any], _ matchStatsLabel: UILabel) {
        let kills = statsSource.integerValueForKey("kills")
        let assists = statsSource.integerValueForKey("assists")
        let deaths = statsSource.integerValueForKey("deaths")
        matchStatsLabel.text! = "\(kills) / \(deaths) / \(assists)"
    }
    
    static func createKdaLabel(_ kills: Int,_ assists: Int, _ deaths: Int) -> String {
        let kda =  Double(Double(kills + assists) / Double(deaths)).rounded(toPlaces: 2)
        return "\(kda) KDA"
    }
    
    static func setBackgroundColor(_ didWin: Bool, view: UIView) {
        if didWin {
            view.backgroundColor = resultColor.green
        } else {
            view.backgroundColor = resultColor.red
        }
    }
}

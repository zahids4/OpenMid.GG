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
        addSeperator()
    }
    
    fileprivate func addSeperator() {
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(2.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.black
        self.addSubview(additionalSeparator)
    }
    
    func configureUsing(_ match: [String:Any]) {
        setChampionNameAndIconFrom(id: match.integerValueForKey("championId"))
        setBackgroundColor(match)
        setStatsLabels(match)
        setSpellImagesFrom(match)
    }
    
    fileprivate func setChampionNameAndIconFrom(id: Int) {
        communicator.getAllChampions() { allChampions, error in
            if allChampions != nil {
                for (key, value) in allChampions! {
                    if Int((value as! [String:Any]).stringValueForKey("key")) == id {
                        self.championNameLabel.text! = key.convertFromApiNameToChampionName().toSpaceSeperated
                        self.championIconImage.setChampionIconWith(name: key)
                    }
                }
            } else {
                print("An error occured: ", error as Any)
            }
            
        }
    }
    
    
    fileprivate func setStatsLabels(_ match: [String : Any]) {
        let kills = match.integerValueForKey("kills")
        let assists = match.integerValueForKey("assists")
        let deaths = match.integerValueForKey("deaths")
        matchStatsLabel.text! = "\(kills) / \(assists) / \(deaths)"
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
    
    fileprivate func setSpellImagesFrom(_ match: [String : Any]) {
        let spell1Name = "spell_\(match.integerValueForKey("spell1Id"))"
        let spell2Name = "spell_\(match.integerValueForKey("spell2Id"))"
        spell1Image.image = UIImage(named: spell1Name)
        spell2Image.image = UIImage(named: spell2Name)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

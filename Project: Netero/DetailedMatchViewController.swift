//
//  DetailedMatchViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-08.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class DetailedMatchViewController: UIViewController {
    @IBOutlet weak var championNameLabel: UILabel!
    @IBOutlet weak var championIconImage: UIImageView!
    @IBOutlet var itemImages: [UIImageView]!
    let communicator = Communicator()
    var match: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UtilityHelper.setChampionNameAndIconFrom(id: match.integerValueForKey("championId")) { key in
            self.championNameLabel.text! = key.convertFromApiNameToChampionName().toSpaceSeperated
            self.championIconImage.setChampionIconWith(name: key)
        }
        setItemImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // DUUPPE extract!
    fileprivate func setItemImages() {
        for (index, item) in itemImages.enumerated() {
            let itemId = match.integerValueForKey("item\(index)")
            if itemId != 0 {
                item.setItemImageWith(id: itemId)
            } else {
                item.image = UIImage(named: "black_line")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "participantsTableVCSegue" {
            let participantsTableVC = segue.destination as! ParticipantsTableViewController
            let details = match.stringAnyObjectForKey("matchDetails")
            participantsTableVC.participants = details.arrayForKey("participants") as! [[String:Any]]
            participantsTableVC.participantIdentities = details.arrayForKey("participantIdentities") as! [[String:Any]]
        }
    }

}

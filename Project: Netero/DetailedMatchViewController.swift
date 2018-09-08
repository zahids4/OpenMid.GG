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
        setChampionNameAndIconFrom(id: match.integerValueForKey("championId"))
        setItemImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    //This is repeated code extract it out! (Also present in match table view cell)
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

}

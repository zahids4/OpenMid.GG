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
    @IBOutlet weak var item0Image: UIImageView!
    @IBOutlet weak var item1Image: UIImageView!
    @IBOutlet weak var item2Image: UIImageView!
    @IBOutlet weak var item3Image: UIImageView!
    @IBOutlet weak var item4Image: UIImageView!
    @IBOutlet weak var item5Image: UIImageView!

    let communicator = Communicator()
    var match: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChampionNameAndIconFrom(id: match.integerValueForKey("championId"))
        item0Image.setItemImageWith(id: match.integerValueForKey("item0"))
        item1Image.setItemImageWith(id: match.integerValueForKey("item1"))
        item2Image.setItemImageWith(id: match.integerValueForKey("item2"))
        item3Image.setItemImageWith(id: match.integerValueForKey("item3"))
        item4Image.setItemImageWith(id: match.integerValueForKey("item4"))
        item5Image.setItemImageWith(id: match.integerValueForKey("item5"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is repeated code extract it out! 
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

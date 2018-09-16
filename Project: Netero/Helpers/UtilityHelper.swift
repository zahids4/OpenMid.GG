//
//  UtilityHelper.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class UtilityHelper {
    static func setChampionNameAndIconFrom(id: Int, completionHandler: @escaping (String) -> ()) {
        let communicator = Communicator()
        communicator.getAllChampions() { allChampions, error in
            if allChampions != nil {
                for (key, value) in allChampions! {
                    if Int((value as! [String:Any]).stringValueForKey("key")) == id {
                        completionHandler(key)
                    }
                }
            } else {
                print("An error occured: ", error as Any)
            }
            
        }
    }
}

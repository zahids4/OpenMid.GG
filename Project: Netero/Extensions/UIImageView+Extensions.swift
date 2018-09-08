//
//  UIImageView+Extensions.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-06-17.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

extension UIImageView {
    func setProfileIconWith(id: Int) {
        setImageWith(imageUrl: "https://ddragon.leagueoflegends.com/cdn/\(AppDelegate.CURRENT_PATCH)/img/profileicon/\(id).png")
    }
    
    func setChampionIconWith(name: String) {
        setImageWith(imageUrl: "http://ddragon.leagueoflegends.com/cdn/\(AppDelegate.CURRENT_PATCH)/img/champion/\(name).png")
    }
    
    func setItemImageWith(id: Int) {
        setImageWith(imageUrl: "http://ddragon.leagueoflegends.com/cdn/\(AppDelegate.CURRENT_PATCH)/img/item/\(id).png")
    }
    
    fileprivate func setImageWith(imageUrl: String) {
        print(imageUrl)
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        self.image = UIImage(data: data!)
    }

}

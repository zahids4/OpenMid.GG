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
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/\(AppDelegate.CURRENT_PATCH)/img/profileicon/\(id).png")
        let data = try? Data(contentsOf: url!)
        self.image = UIImage(data: data!)
    }
    
    func setChampionIconWith(name: String) {
        let url = URL(string: "http://ddragon.leagueoflegends.com/cdn/\(AppDelegate.CURRENT_PATCH)/img/champion/\(name).png")
        let data = try? Data(contentsOf: url!)
        self.image = UIImage(data: data!)
    }
}

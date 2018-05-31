//
//  ButtonStyling.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-05-31.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

extension UIButton {
    func defaultStyle() {
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor(displayP3Red: 141/255, green: 221/255, blue: 251/255, alpha: 1.0)
        self.tintColor = UIColor.white
    }
}

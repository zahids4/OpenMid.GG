//
//  UILabel+Extensions.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-07-07.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

extension UILabel {
    func hide() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
    func enable() {
        self.isEnabled = true
    }
    
    func disable() {
        self.isEnabled = false
    }
}

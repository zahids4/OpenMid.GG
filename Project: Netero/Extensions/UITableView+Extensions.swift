//
//  UITable+Extensions.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-16.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

extension UITableView {
    func addBorder() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
    }
}

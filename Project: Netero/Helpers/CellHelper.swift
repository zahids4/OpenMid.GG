//
//  CellHelper.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-16.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class CellHelper {
    static func addSeperator(_ cell: UITableViewCell) {
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(2.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: cell.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.black
        cell.addSubview(additionalSeparator)
    }
    
}

struct resultColor {
    static let green = UIColor(displayP3Red: 117/255, green: 251/255, blue: 172/255, alpha: 0.8)
    static let red = UIColor(displayP3Red: 176/255, green: 50/255, blue: 53/255, alpha: 0.8)
}

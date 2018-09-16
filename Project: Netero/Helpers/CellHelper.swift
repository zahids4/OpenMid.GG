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

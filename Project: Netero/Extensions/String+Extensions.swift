//
//  String+Extensions.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-08-16.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

extension String {
    var toSpaceSeperated: String {
        struct Seperation {
            static let regex = try! NSRegularExpression(pattern: "[A-Z]")
        }
        
        return Seperation.regex.stringByReplacingMatches(in: self, range: NSRange(0..<self.utf16.count), withTemplate: " $0")
    }
    
    var convertFromApiNameToChampionName: String {
        switch self {
        case "Monkey King":
            return "Wukong"
        default:
            return self
        }
    }
}


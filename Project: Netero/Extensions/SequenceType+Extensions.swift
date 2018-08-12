//
//  SequenceType+Extensions.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-08-12.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

extension Sequence {
    func find(predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self.Iterator.Element? {
        for element in self {
            if try predicate(element) {
                return element
            }
        }
        return nil
    }
}

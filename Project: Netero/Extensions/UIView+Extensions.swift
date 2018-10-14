//
//  UIView+Extensions.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-10-14.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit
import SkeletonView

extension UIView {
    func addGradient() {
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        self.showAnimatedGradientSkeleton(usingGradient: gradient)
    }
}

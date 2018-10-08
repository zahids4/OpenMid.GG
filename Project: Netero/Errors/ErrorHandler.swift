//
//  ErrorHandler.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-06-03.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit
class ErrorHandler {
    func showErrorAlert(alertTitle: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

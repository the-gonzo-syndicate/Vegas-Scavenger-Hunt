//
//  Alert.swift
//  Vegas-Scavenger-Hunt
//
//  Created by Andrew on 4/23/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        vc.present(alert, animated: true, completion: nil)
    }
}

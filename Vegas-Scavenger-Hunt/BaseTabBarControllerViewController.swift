//
//  BaseTabBarControllerViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by Andrew on 4/7/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class BaseTabBarControllerViewController: UITabBarController {
    
    //@IBInspectable var defaultIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 1

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  BloodAlcoholContentNavigationViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/25/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class BloodAlcoholContentNavigationViewController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var cachedBloodAlcoholContent: BloodAlcoholContent!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

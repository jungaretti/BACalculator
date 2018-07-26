//
//  ThemedNavigationViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/25/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class ThemedNavigationViewController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var bloodAlcoholContent: BloodAlcoholContent?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func matchNavigationBarToTheme() {
        if let bloodAlcoholContent = bloodAlcoholContent {
            navigationBar.barTintColor = ColorManager.themeColor(forBAC: bloodAlcoholContent).dark
        }
    }

}

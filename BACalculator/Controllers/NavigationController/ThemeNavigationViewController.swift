//
//  ThemeNavigationViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/25/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

class ThemeNavigationViewController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var themeColor: ThemeColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = themeColor.dark
        topViewController?.view.backgroundColor = themeColor.normal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

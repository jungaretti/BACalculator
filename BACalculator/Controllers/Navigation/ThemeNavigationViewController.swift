//
//  ThemeNavigationViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class ThemeNavigationViewController: UINavigationController {
    
    var themeColor: ThemeColor?
    var topViewShouldMatchTheme: Bool?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if themeColor != nil { return .lightContent }
        else { return .default }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let themeColor = self.themeColor {
            navigationBar.barTintColor = themeColor.dark
            navigationBar.tintColor = UIColor.white
            navigationBar.titleTextAttributes = [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!,
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
            if let shouldMatchTheme = self.topViewShouldMatchTheme, shouldMatchTheme {
                topViewController?.view.backgroundColor = themeColor.normal
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

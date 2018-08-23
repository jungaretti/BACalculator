//
//  ColoredBarNavigationController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class ColoredBarNavigationController: UINavigationController {
    
    var preferredBarTintColor: UIColor?
    var preferredViewBackgroundColor: UIColor?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if preferredBarTintColor != nil { return UIStatusBarStyle.lightContent }
        else { return UIStatusBarStyle.default }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let barTintColor = preferredBarTintColor {
            navigationBar.barTintColor = barTintColor
            navigationBar.tintColor = UIColor.white
            navigationBar.titleTextAttributes = [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!,
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

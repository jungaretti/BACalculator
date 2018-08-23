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
        designBar()
        setupCloseButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissColoredBarNavigationController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func designBar() {
        if let preferredBarTintColor = self.preferredBarTintColor {
            navigationBar.barTintColor = preferredBarTintColor
            navigationBar.tintColor = UIColor.white
            navigationBar.titleTextAttributes = [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!,
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
        }
    }
    
    private func setupCloseButton() {
        if let topViewController = self.topViewController {
            let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissColoredBarNavigationController(_:)))
            topViewController.navigationItem.setLeftBarButton(closeButton, animated: false)
        }
    }

}

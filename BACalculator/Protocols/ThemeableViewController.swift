//
//  ThemeableViewController.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/19/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

protocol ThemeableViewController {
    
    var themeColor: ThemeColor? { get set }
    var topViewShouldMatchTheme: Bool? { get set }

}

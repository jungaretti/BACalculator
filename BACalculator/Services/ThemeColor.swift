//
//  ThemeColor.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/22/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation
import UIKit

struct ThemeColor {
    
    /// Determine the proper theme colors for a certain `BloodAlcoholContent`.
    ///
    /// - Parameter bloodAlcoholContent: The `BloodAlcoholContent` to determine theme colors for.
    /// - Returns: The theme colors for the `BloodAlcoholContent`.
    static func themeColor(forBAC bloodAlcoholContent: BloodAlcoholContent) -> (normal: UIColor, dark: UIColor) {
        let color: (normal: UIColor, dark: UIColor)
        if bloodAlcoholContent <= 0.02 {
            color = (UIColor(named: "Green")!, UIColor(named: "Green-Dark")!)
        } else if bloodAlcoholContent <= 0.06 {
            color = (UIColor(named: "Orange")!, UIColor(named: "Orange-Dark")!)
        } else {
            color = (UIColor(named: "Red")!, UIColor(named: "Red-Dark")!)
        }
        return color
    }
    
}

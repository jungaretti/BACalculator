//
//  ThemeAgent.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/25/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

/// An object for operations relating to the color theme.
struct ThemeAgent {
    
    /// Determine the proper theme colors for a certain `BloodAlcoholContent`.
    ///
    /// - Parameter bloodAlcoholContent: The `BloodAlcoholContent` to determine theme colors for.
    /// - Returns: The theme colors for the `BloodAlcoholContent`.
    static func themeColor(forBAC bloodAlcoholContent: BloodAlcoholContent) -> ThemeColor {
        let color: ThemeColor
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

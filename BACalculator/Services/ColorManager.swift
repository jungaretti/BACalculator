//
//  ColorManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/25/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import UIKit

struct ColorManager {
    
    static func themeColor(forBAC bloodAlcoholContent: BloodAlcoholContent) -> (normal: UIColor?, dark: UIColor?) {
        if bloodAlcoholContent <= 0.02 {
            return (UIColor(named: "Green"), UIColor(named: "Green-Dark"))
        } else if bloodAlcoholContent <= 0.06 {
            return (UIColor(named: "Orange"), UIColor(named: "Orange-Dark"))
        } else {
            return (UIColor(named: "Red"), UIColor(named: "Red-Dark"))
        }
    }
    
}

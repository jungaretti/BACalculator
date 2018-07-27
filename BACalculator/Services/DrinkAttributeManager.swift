//
//  DrinkAttributeManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation

struct DrinkAttributeManager {
    
    static var drinkTypes: [DrinkType] = [.beer, .wine, .liquor, .mixed]
    static var standardDrinkSizes: [Int] = Array(1...5)
    
    static func image(forDrinkType drinkType: DrinkType) -> UIImage? {
        switch drinkType {
        case .beer:
            return UIImage(named: "Beer")
        case .wine:
            return UIImage(named: "Wine")
        case .liquor:
            return UIImage(named: "Liquor")
        case .mixed:
            return UIImage(named: "Mixed")
        }
    }
    
    static func unitDescription(forStandardDrinks standardDrinks: Int) -> String {
        if standardDrinks == 1 {
            return "Standard Drink"
        } else {
            return "Standard Drinks"
        }
    }
    
}

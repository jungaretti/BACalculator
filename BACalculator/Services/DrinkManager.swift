//
//  DrinkManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation

class DrinkManager {
    
    static var drinks: [Drink] = {
        var drinks = [Drink]()
        drinks.append(Drink(type: .wine, consumptionDate: Date().addingTimeInterval(-3600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .liquor, consumptionDate: Date().addingTimeInterval(-1800.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        return drinks
    }()
    
}

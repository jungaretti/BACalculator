//
//  StandardDrinkSize.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A measurement of an alcoholic drink measured in United States standard drinks.
public struct StandardDrinkSize: DrinkSize {
    
    /// The mass of alcohol in an United States standard drink.
    static let standardDrinkAlcoholMass = Measurement(value: 14.0, unit: UnitMass.grams)
    
    /// The size of the drink in standard drinks.
    public var standardDrinks: Double
    public var alcoholMass: Measurement<UnitMass> {
        return standardDrinks * StandardDrinkSize.standardDrinkAlcoholMass
    }
    public var isEmpty: Bool {
        if standardDrinks == 0.0 { return true }
        else { return false }
    }
    
    /// Create a `StandardDrinkSize` using a specific number of standard drinks.
    ///
    /// - Parameter standardDrinks: The size of the drink in standard drinks.
    public init(standardDrinks: Double) {
        if standardDrinks > 0.0 { self.standardDrinks = standardDrinks }
        else { self.standardDrinks = 0.0 }
    }
    
}

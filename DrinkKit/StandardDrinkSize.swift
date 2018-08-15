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
    
    public var alcoholMass: Measurement<UnitMass> {
        return standardDrinks * StandardDrinkSize.standardDrinkAlcoholMass
    }
    public var description: String {
        return "\(format(value: standardDrinks)) sd"
    }
    public var isEmpty: Bool {
        if standardDrinks == 0.0 { return true }
        return false
    }
    /// The size of the drink in standard drinks.
    public var standardDrinks: Double
    
    /// Create a `StandardDrinkSize` using a specific number of standard drinks.
    ///
    /// - Parameter standardDrinks: The size of the drink in standard drinks.
    public init(standardDrinks: Double) {
        if standardDrinks > 0.0 { self.standardDrinks = standardDrinks }
        else { self.standardDrinks = 0.0 }
    }
    
    public func description(forType type: DrinkType) -> String {
        let formattedValue = format(value: standardDrinks)
        let roundedValue = Double(formattedValue)!
        return "\(formattedValue) \(type.unit(forQuantity: roundedValue))"
    }
    
    private func format(value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: value))!
    }
    
}

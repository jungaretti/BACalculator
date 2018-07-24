//
//  DrinkSize.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A measurement of an alcoholic drink's size.
public protocol DrinkSize {
    
    /// The mass of alcohol in a drink.
    var alcoholMass: Measurement<UnitMass> { get }
    /// A Boolean value that indicates if the drink is empty.
    var isEmpty: Bool { get }
    
}

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

/// A measurement of an alcoholic drink with a specific volume and alcohol ratio.
public struct CustomDrinkSize: DrinkSize {
    
    /// The specific gravity of alcohol.
    private static let alcoholSpecificGravity: Double = 0.79
    
    /// The volume of the drink.
    public var volume: Measurement<UnitVolume>
    /// The alcohol ratio (ABV) of the drink.
    public var alcoholRatio: Double
    public var alcoholMass: Measurement<UnitMass> {
        let alcoholVolumeML = volume.converted(to: UnitVolume.milliliters).value * alcoholRatio
        let alcoholMassG = alcoholVolumeML * CustomDrinkSize.alcoholSpecificGravity
        return Measurement(value: alcoholMassG, unit: UnitMass.grams)
    }
    public var isEmpty: Bool {
        if volume.value == 0.0 || alcoholRatio == 0.0 { return true }
        else { return false }
    }
    
    /// Create a `CustomDrinkSize` with a specific volume and alcohol ratio.
    ///
    /// - Parameters:
    ///   - volume: The volume of the drink.
    ///   - alcoholRatio: The alcohol ratio (alcohol by volume) of the drink.
    public init(volume: Measurement<UnitVolume>, alcoholRatio: Double) {
        // Check that the drink's volume is greater than 0.0
        if volume.value > 0.0 { self.volume = volume }
        else { self.volume = Measurement(value: 0.0, unit: UnitVolume.milliliters) }
        // Check that the drink's alcohol ratio is greater than 0.0
        if alcoholRatio > 0.0 { self.alcoholRatio = alcoholRatio }
        else { self.alcoholRatio = 0.0 }
    }
    
}

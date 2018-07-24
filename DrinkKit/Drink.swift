//
//  Drink.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// An alcoholic drink.
public struct Drink: Comparable {
    
    /// The type of alcoholic beverage.
    public var type: DrinkType
    /// The consumption date of the drink.
    public var consumptionDate: Date
    /// The size of the drink
    public var size: DrinkSize
    
    /// Create a `Drink` with a specific type, consumption date, and size.
    ///
    /// - Parameters:
    ///   - type: The type of alcoholic beverage.
    ///   - consumptionDate: The consumption date of the drink.
    ///   - size: The size of the drink.
    public init(type: DrinkType, consumptionDate: Date, size: DrinkSize) {
        self.type = type
        self.consumptionDate = consumptionDate
        self.size = size
    }
    
    public static func < (lhs: Drink, rhs: Drink) -> Bool {
        return lhs.size.alcoholMass < rhs.size.alcoholMass
    }
    
    public static func == (lhs: Drink, rhs: Drink) -> Bool {
        return lhs.size.alcoholMass == rhs.size.alcoholMass
    }
    
}

/// Constants describing different types of alcoholic beverages.
public enum DrinkType {
    
    case beer
    case wine
    case liquor
    case mixed
    
}

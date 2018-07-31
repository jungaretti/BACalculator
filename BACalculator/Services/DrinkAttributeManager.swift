//
//  DrinkAttributeManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit

/// A persistent storage manager for attributes of a `Drink`.
struct DrinkAttributeManager {
    
    /// Choices for `DrinkType`s.
    static let types: [DrinkType] = [.beer, .wine, .liquor, .mixed]
    /// Choices for `StandardDrinkSize` quantities.
    static let standardSizes: [Int] = Array(1...5)
    
    /// Determine the appropriate icon for a specific `DrinkType`.
    ///
    /// - Parameter type: The `DrinkType` to find an icon for.
    /// - Returns: The `UIImage` corresponding to the `DrinkType`.
    static func icon(forType type: DrinkType) -> UIImage? {
        switch type {
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
    
}